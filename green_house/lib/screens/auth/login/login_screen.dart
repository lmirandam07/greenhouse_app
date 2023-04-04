import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/screens/auth/signup/signup_screen.dart';
import 'package:green_house/services/firestore_services/firestore_services.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/google_btn.dart';
import '../../bottom/bottom_nav_screen.dart';
import '../forgot_pass/forgot_pass_screen.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// body
      body: Obx(() {
        return LoadingOverlay(
          opacity: 0.1,
          isLoading: loginController.isLoading.value,
          progressIndicator: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Get.theme.primaryColor)),
          child: SafeArea(
            child: Form(
                key: _formKey,
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
                            'Hey, Bienvenido!',
                            style: montserratSemiBold.copyWith(
                              fontSize: heading28,
                              color: AppColors.blackMainColor,
                            ),
                          ),
                        ),

                        /// email field
                        SizedBox(height: screenHeight(context) * 0.03),
                        CustomTextField(
                          controller: loginController.emailController,
                          headText: 'Correo electrónico',
                          hintText: 'ejemplo@gmail.com',
                          prefixIconPath: AppIcons.mailIcon,
                          keyboardType: TextInputType.emailAddress,
                          validator: AppValidations.validateEmail,
                        ),

                        /// pass field
                        SizedBox(height: screenHeight(context) * 0.02),
                        CustomTextField(
                          controller: loginController.passController,
                          headText: 'Contraseña',
                          hintText: '',
                          prefixIconPath: AppIcons.lockIcon,
                          obscureText: loginController.isPassObscure.value,
                          suffixIcon: IconButton(
                            onPressed: () {
                              loginController.isPassObscure.value =
                                  !loginController.isPassObscure.value;
                            },
                            icon: SvgPicture.asset(AppIcons.eyeIcon),
                          ),
                          validator: AppValidations.validatePassword,
                        ),

                        /// forgot pass
                        SizedBox(height: screenHeight(context) * 0.01),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: TextButton(
                              onPressed: () {
                                Get.to(ForgotPassScreen());
                              },
                              child: Text(
                                '¿Olvidaste tu contraseña?',
                                style: montserratMedium.copyWith(
                                  fontSize: body13,
                                  color: AppColors.blueColor.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                        ),

                        /// login btn
                        SizedBox(height: screenHeight(context) * 0.006),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenHeight(context) * 0.036),
                          child: CustomButton(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                loginController.signIn();
                              }
                            },
                            btnText: 'Iniciar sesion',
                          ),
                        ),

                        /// or login
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
                                  color:
                                      AppColors.dividerColor.withOpacity(0.15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  'O Iniciar sesión en uso',
                                  style: montserratRegular.copyWith(
                                    fontSize: body12,
                                    color: AppColors.blackMainColor
                                        .withOpacity(0.6),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  height: 1.0,
                                  thickness: 1.0,
                                  color:
                                      AppColors.dividerColor.withOpacity(0.15),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// google button
                        SizedBox(height: screenHeight(context) * 0.02),
                        GoogleButton(
                          onTap: () async {
                            await FirestoreService.signInWithGoogle(
                                context: context);
                          },
                        ),

                        /// don't have account
                        SizedBox(height: screenHeight(context) * 0.05),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Es tu primera vez aquí?',
                              style: montserratRegular.copyWith(
                                fontSize: body16,
                                color: AppColors.blackMainColor,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            GestureDetector(
                              onTap: () {
                                Get.to(SignupScreen());
                              },
                              child: Text(
                                'Registrate',
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
                )),
          ),
        );
      }),
    );
  }
}
