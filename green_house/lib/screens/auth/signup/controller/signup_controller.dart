import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/models/user_model.dart';
import 'package:green_house/screens/auth/login/login_screen.dart';
import 'package:green_house/widgets/custom_snackbar.dart';

class SignupController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  RxBool isPassObscure = true.obs;
  RxBool isConfirmPassObscure = true.obs;
  var isLoading = false.obs;

  Future<dynamic> signUp() async {
    try {
      isLoading(true);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      )
          .then((value) async {
        successSnackBar('Cuenta creada exitosamente');
        final user = UserModel(
            name: 'Alexander',
            username: 'messijabu1014',
            email: emailController.text,
            password: passController.text);
        user.createUser(user);
        emailController.clear();
        passController.clear();
        confirmPassController.clear();
        Get.off(LoginScreen());
        isLoading(false);
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
