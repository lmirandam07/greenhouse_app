import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/screens/auth/login/login_screen.dart';
import 'package:green_house/widgets/custom_button.dart';
import 'package:green_house/widgets/custom_text_field.dart';
import 'package:green_house/widgets/google_btn.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../constants/exports.dart';
import 'controller/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        /// body
        body: Obx(() {
          return LoadingOverlay(
            opacity: 0.1,
            isLoading: signupController.isLoading.value,
            progressIndicator: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor:
                    AlwaysStoppedAnimation<Color>(Get.theme.primaryColor)),
            child: SafeArea(
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

                      /// name hi
                      SizedBox(height: screenHeight(context) * 0.03),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenHeight(context) * 0.036),
                        child: Text(
                          '¡Bienvenido a Greenhouse!',
                          style: montserratSemiBold.copyWith(
                            fontSize: heading28,
                            color: AppColors.blackMainColor,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight(context) * 0.03),
                      CustomTextField(
                        controller: signupController.usernameController,
                        headText: 'Username',
                        hintText: '',
                        prefixIconPath: AppIcons.userIcon,
                        keyboardType: TextInputType.text,
                        validator: AppValidations.validateRequired,
                      ),

                      /// email field
                      SizedBox(height: screenHeight(context) * 0.03),
                      CustomTextField(
                        controller: signupController.emailController,
                        headText: 'Correo electrónico',
                        hintText: 'example@gmail.com',
                        prefixIconPath: AppIcons.mailIcon,
                        keyboardType: TextInputType.emailAddress,
                        validator: AppValidations.validateEmail,
                      ),

                      /// pass field
                      SizedBox(height: screenHeight(context) * 0.02),
                      CustomTextField(
                        controller: signupController.passController,
                        headText: 'Contraseña',
                        hintText: '',
                        prefixIconPath: AppIcons.lockIcon,
                        validator: AppValidations.validatePassword,
                        obscureText: signupController.isPassObscure.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            signupController.isPassObscure.value =
                                !signupController.isPassObscure.value;
                          },
                          icon: SvgPicture.asset(AppIcons.eyeIcon),
                        ),
                      ),

                      /// confirm pass field
                      SizedBox(height: screenHeight(context) * 0.02),
                      CustomTextField(
                        controller: signupController.confirmPassController,
                        headText: 'Repetir Contraseña',
                        hintText: '',
                        prefixIconPath: AppIcons.lockIcon,
                        validator: validateConfirmPassword,
                        obscureText:
                            signupController.isConfirmPassObscure.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            signupController.isConfirmPassObscure.value =
                                !signupController.isConfirmPassObscure.value;
                          },
                          icon: SvgPicture.asset(AppIcons.eyeIcon),
                        ),
                      ),

                      /// register btn
                      SizedBox(height: screenHeight(context) * 0.03),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenHeight(context) * 0.036),
                        child: CustomButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              signupController.signUp();
                            }
                          },
                          btnText: 'Registrarse',
                        ),
                      ),

                      /// or register
                      SizedBox(height: screenHeight(context) * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenHeight(context) * 0.045),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                height: 1.0,
                                thickness: 1.0,
                                color: AppColors.dividerColor.withOpacity(0.15),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'O inicia sesisón con',
                                style: montserratRegular.copyWith(
                                  fontSize: body12,
                                  color:
                                      AppColors.blackMainColor.withOpacity(0.6),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                height: 1.0,
                                thickness: 1.0,
                                color: AppColors.dividerColor.withOpacity(0.15),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// google button
                      SizedBox(height: screenHeight(context) * 0.02),
                      GoogleButton(
                        onTap: () async {
                          signupController.signUpGoogle(context);
                        },
                      ),

                      /// already have account
                      SizedBox(height: screenHeight(context) * 0.05),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ya tienes una cuenta?',
                            style: montserratRegular.copyWith(
                              fontSize: body16,
                              color: AppColors.blackMainColor,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          GestureDetector(
                            onTap: () {
                              Get.to(LoginScreen());
                            },
                            child: Text(
                              'Ingresa',
                              style: montserratBold.copyWith(
                                fontSize: body16,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  String? validateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return "required";
    } else if (value.length < 6) {
      return "Password length should be atleast 6";
    } else if (value != signupController.passController.text) {
      return "Password not match";
    } else {
      return null;
    }
  }
}
