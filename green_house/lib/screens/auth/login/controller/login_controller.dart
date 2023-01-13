import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/screens/bottom/bottom_nav_screen.dart';
import 'package:green_house/widgets/custom_snackbar.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  RxBool isPassObscure = true.obs;
  var isLoading = false.obs;

  signIn() async {
    try {
      isLoading(true);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      )
          .then((value) async {
        successSnackBar('Inicio exitoso');
        emailController.clear();
        passController.clear();
        Get.offAll(BottomNavBar());
        isLoading(false);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorSnackBar('No existe este usuario intente nuevamente.');
      } else if (e.code == 'wrong-password') {
        errorSnackBar('Contraseña incorrecta. Favor intente nuevamente');
      } else {
        errorSnackBar('Ups! Algo ha pasado. Intente nuevamente');
      }
      isLoading(false);
    }
  }
}
