import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:damh_flutter/consts/consts.dart';
import 'package:damh_flutter/consts/lists.dart';
import 'package:damh_flutter/controllers/auth_controller.dart';
import 'package:damh_flutter/controllers/profile_controller.dart';
import 'package:damh_flutter/screens/auth_screens/login_screen.dart';
import 'package:damh_flutter/screens/profile_screens/components/details_cart.dart';
import 'package:damh_flutter/screens/profile_screens/edit_profile_sceen.dart';
import 'package:damh_flutter/services/firestore_services.dart';
import 'package:damh_flutter/widgets/bg_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileCotroller());

    // Lấy người dùng hiện tại từ Firebase Auth
    final currentUser = FirebaseAuth.instance.currentUser;

    // Chuyển hướng đến LoginScreen nếu chưa đăng nhập
    if (currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAll(() => const LoginScreen());
      });
      return const Center(
        child: CircularProgressIndicator(), // Hiển thị loader trong thời gian ngắn
      );
    }

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: currentUser != null
              ? FirestoreServices.getUser(currentUser!.uid)
              : null,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else if (!snapshot.hasData || currentUser == null) {
              return const Center(
                child: Text("No user data available", style: TextStyle(color: whiteColor)),
              );
            }
            else {

              var data = snapshot.data!.docs[0];

              return SafeArea(
                  child: Column(
                    children: [
                      //edit profile
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Align(
                          alignment: Alignment.topRight, child: Icon(Icons.edit, color: whiteColor),
                        ).onTap((){
                          controller.nameController.text = data['name'];
                          controller.passController.text = data['password'];
                          Get.to(()=> EditProfileSceen(data: data));
                        }),
                      ) ,
                      //user detail

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Image.asset(imgProfile2, width: 100, fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),
                            10.widthBox,
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['name']}".text.fontFamily(semibold).white.make(),
                                "${data['email']}".text.white.make(),
                              ],
                            )),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: whiteColor
                                  )
                              ),
                              onPressed: () async {
                                await Get.put(AuthController()).signoutMethod(context: context);
                                Get.offAll(()=> const LoginScreen());
                              },
                              child: logout.text.fontFamily(semibold).white.make(),
                            )
                          ],
                        ),
                      ),

                      20.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          detailsCard(count: data['cart_count'], title: "In your cart", width: context.screenWidth / 3.4),
                          detailsCard(count: data['wishlist_count'], title: "In your wishlist", width: context.screenWidth / 3.4),
                          detailsCard(count: data['order_count'], title: "Your orders", width: context.screenWidth / 3.4),
                        ],
                      ),

                      //button section
                      ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: lightGrey,
                            );
                          },
                          itemCount: profilesButtonList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Image.asset(
                                profilesButtonIcon[index],
                                width: 22,
                              ),
                              title: profilesButtonList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                            );
                          }
                      ).box.white.rounded.margin(const EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.color(redColor).make(),
                    ],
                  )
              );
            }
          },
        )
      )
    );
  }
}