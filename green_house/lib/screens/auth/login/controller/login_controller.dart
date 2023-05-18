import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/screens/bottom/bottom_nav_screen.dart';
import 'package:green_house/widgets/custom_snackbar.dart';

import '../../../../models/user_model.dart';
import '../../../../services/firestore_services/firestore_services.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final firestoreService = FirestoreService();
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

  signInGoogle(context) async {
    try {
      isLoading(true);
      await FirestoreService.signInWithGoogle(context: context)
          .then((value) async {
        if (await firestoreService.validateUserExistByEmail(value?.email)) {
          successSnackBar('Inicio exitoso');
          emailController.clear();
          passController.clear();
          Get.offAll(BottomNavBar());
          isLoading(false);
        } else {
          final user = UserModel(
              name: value?.displayName,
              username: value?.displayName,
              email: value?.email,
              password: '123456',
              profile: 'https://firebasestorage.googleapis.com/v0/b/green-house-app-4828a.appspot.com/o/default%2Fdefault.png?alt=media&token=6589ce94-d767-4fd5-b728-cf1d55fa77d7');
          await firestoreService.createUser(user, value?.uid);
          successSnackBar('Inicio exitoso');
          emailController.clear();
          passController.clear();
          Get.offAll(BottomNavBar());
          isLoading(false);
        }
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
