import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import 'controller/forgot_pass_controller.dart';

class ForgotPassScreen extends StatelessWidget {
  ForgotPassScreen({Key? key}) : super(key: key);

  final ForgotPassController forgotPassController =
      Get.put(ForgotPassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// body
      body: SafeArea(
        child: SizedBox(
          height: screenHeight(context),
          width: screenWidth(context),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// image
                Center(
                  child: Image.asset(
                    AppImages.appLogo,
                    color: AppColors.primaryColor,
                    height: 125,
                    width: 125,
                  ),
                ),

                SizedBox(height: screenHeight(context) * 0.02),
                CustomTextField(
                  controller: forgotPassController.emailController,
                  headText: 'Correo',
                  hintText: 'ejemplo@gmail.com',
                  prefixIconPath: AppIcons.lockIcon,
                ),

                /// buttons
                SizedBox(height: screenHeight(context) * 0.024),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenHeight(context) * 0.036),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          onTap: () async {
                            await forgotPassController.resetPassword(
                                forgotPassController.emailController.text);
                          },
                          btnText: 'Restaurar',
                        ),
                      ),
                      SizedBox(width: screenHeight(context) * 0.024),
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            Get.back();
                          },
                          btnText: 'Regresar',
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
