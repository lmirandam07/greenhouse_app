import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/models/user_model.dart';
import 'package:green_house/screens/auth/login/login_screen.dart';
import 'package:green_house/widgets/custom_snackbar.dart';

import '../../../../services/firestore_services/user_services.dart';
import '../signup_screen.dart';

class SignupController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  RxBool isPassObscure = true.obs;
  RxBool isConfirmPassObscure = true.obs;
  final userService = UserService();
  var isLoading = false.obs;
  Future<dynamic> signUp() async {
    try {
      isLoading(true);
      await userService
          .validateUserExist(usernameController.text)
          .then((value) async {
        if (value) {
          errorSnackBar('Ya existe el usuario');
          Get.off(SignupScreen());
          isLoading(false);
        } else {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passController.text.trim(),
          )
              .then((value) async {
            final user = UserModel(
                name: 'Alexander',
                username: usernameController.text,
                email: emailController.text,
                password: passController.text);
            successSnackBar('Cuenta creada correctamente');
            userService.createUser(user);
            emailController.clear();
            passController.clear();
            confirmPassController.clear();
            Get.off(LoginScreen());
            isLoading(false);
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorSnackBar('La contrasena es muy debil.');
      } else if (e.code == 'email-already-in-use') {
        errorSnackBar('Ya existe una cuenta con este email');
      } else {
        errorSnackBar('Algo ha salido mal. Intenta nuevamente');
      }
      isLoading(false);
    }
  }
}
