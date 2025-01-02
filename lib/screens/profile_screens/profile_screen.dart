import 'package:damh_flutter/consts/consts.dart';
import 'package:damh_flutter/consts/lists.dart';
import 'package:damh_flutter/screens/profile_screens/components/details_cart.dart';
import 'package:damh_flutter/widgets/bg_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        body: SafeArea(
            child: Column(
              children: [
                //edit profile
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: const Align(
                    alignment: Alignment.topRight, child: Icon(Icons.edit, color: whiteColor),
                 ).onTap((){}),
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
                          "Dummy User".text.fontFamily(semibold).white.make(),
                          "costomer@example.com".text.white.make(),
                        ],
                      )),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: whiteColor
                          )
                        ),
                          onPressed: (){},
                          child: logout.text.fontFamily(semibold).white.make(),
                      )
                    ],
                  ),
                ),

                20.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    detailsCard(count: "00", title: "In your cart", width: context.screenWidth / 3.4),
                    detailsCard(count: "32", title: "In your wishlist", width: context.screenWidth / 3.4),
                    detailsCard(count: "675", title: "Your orders", width: context.screenWidth / 3.4),
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
                ).box.white.rounded.margin(EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.color(redColor).make(),
              ],
            )
        ),
      )
    );
  }
}