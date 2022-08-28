import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/screens/dialogs/leave_home.dart';
import 'package:green_house/screens/profile/components/registered_box.dart';
import 'package:green_house/screens/profile/controller/profile_controller.dart';
import 'package:green_house/widgets/custom_button.dart';
import 'package:green_house/widgets/custom_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// body
      body: SafeArea(
        child: SizedBox(
          height: screenHeight(context),
          width: screenWidth(context),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// user image
                SizedBox(height: screenHeight(context) * 0.02),
                Image.asset(
                  AppImages.avatarImage,
                  height: screenHeight(context) * 0.16,
                ),

                /// btn
                SizedBox(height: screenHeight(context) * 0.016),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenHeight(context) * 0.1),
                  child: CustomButton(onTap: () {}, btnText: 'Cambiar Avatar'),
                ),

                /// field
                SizedBox(height: screenHeight(context) * 0.032),
                CustomTextField(
                  controller: profileController.userNameController,
                  headText: 'Nombre del usuario',
                  hintText: 'johnsondoe',
                  prefixIconPath: AppIcons.userIcon,
                ),

                /// registered household
                SizedBox(height: screenHeight(context) * 0.032),
                Container(
                  width: screenWidth(context),
                  margin: EdgeInsets.symmetric(
                    horizontal: screenHeight(context) * 0.032,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius10),
                    color: AppColors.whiteColor,
                    boxShadow: [
                      mainShadow,
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///
                      Container(
                        width: screenWidth(context),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight(context) * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radius10),
                            topRight: Radius.circular(radius10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Hogares registrados',
                            style: montserratRegular.copyWith(
                              fontSize: body18,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                      RegisteredBox(onTap: () {
                        Get.dialog(
                          LeaveHomeDialog(),
                        );
                      }),
                      RegisteredBox(onTap: () {
                        Get.dialog(
                          LeaveHomeDialog(),
                        );
                      }),
                      RegisteredBox(onTap: () {
                        Get.dialog(
                          LeaveHomeDialog(),
                        );
                      }),

                      SizedBox(height: screenHeight(context) * 0.02),
                    ],
                  ),
                ),

                /// save and discard btn
                SizedBox(height: screenHeight(context) * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomButton(
                          onTap: () {},
                          btnText: 'Guardar',
                        ),
                      ),
                      SizedBox(width: screenHeight(context) * 0.02),
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            Get.back();
                          },
                          btnText: 'Descartar',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
