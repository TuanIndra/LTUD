import 'dart:io';

import 'package:damh_flutter/consts/consts.dart';
import 'package:damh_flutter/controllers/profile_controller.dart';
import 'package:damh_flutter/widgets/bg_widget.dart';
import 'package:damh_flutter/widgets/custom_textfield.dart';
import 'package:damh_flutter/widgets/our_button.dart';
import 'package:get/get.dart';


class EditProfileSceen extends StatelessWidget {

  final dynamic data;

  const EditProfileSceen({super.key, this.data});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProfileCotroller>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.profileImgPath.isEmpty
                  ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                  : Image.file(
                    File(controller.profileImgPath.value),
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make(),

              10.heightBox,
              ourButton(
                  color: redColor,
                  onPress: (){
                    controller.changeImage(context);
                  },
                  textcolor: whiteColor,
                  title: "Change",
              ),
              const Divider(),
              20.heightBox,
              customTextField(controller: controller.nameController,hint: nameHint, title: name, isPass: false),
              customTextField(controller: controller.passController,hint: password, title: password, isPass: true),
              20.heightBox,
              controller.isLoading.value
                  ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                  : SizedBox(
                  width: context.screenWidth - 60,
                  child: ourButton(
                      color: redColor,
                      onPress: () async {
                        try {
                          controller.isLoading(true); // Đặt trạng thái loading là true
                          // Tải ảnh lên Firebase Storage
                          await controller.uploadProfileImage();

                          // Cập nhật thông tin người dùng trong Firestore
                          await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController.text,
                            password: controller.passController.text,
                          );

                          VxToast.show(context, msg: "Profile updated successfully");
                        } catch (e) {
                          VxToast.show(context, msg: "Failed to update profile: $e");
                        } finally {
                          controller.isLoading(false); // Đặt trạng thái loading về false dù có lỗi hay không
                        }
                      },
                      textcolor: whiteColor, title: "Save")

              ),
            ],
          )
              .box
              .white
              .shadowSm
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .rounded
              .make(),
        ),
      )
    );
  }
}
