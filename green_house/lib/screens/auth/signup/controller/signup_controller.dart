import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/models/user_model.dart';
import 'package:green_house/screens/auth/login/login_screen.dart';
import 'package:green_house/widgets/custom_snackbar.dart';

import '../../../../services/firestore_services/firestore_services.dart';
import '../../../bottom/bottom_nav_screen.dart';
import '../signup_screen.dart';

class SignupController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  RxBool isPassObscure = true.obs;
  RxBool isConfirmPassObscure = true.obs;
  final firestoreService = FirestoreService();
  var isLoading = false.obs;
  Future<dynamic> signUp() async {
    try {
      isLoading(true);
      await firestoreService
          .validateUserExist(usernameController.text)
          .then((value) async {
        if (value) {
          errorSnackBar('Ya existe el usuario');
          isLoading(false);
        } else {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passController.text.trim(),
          )
              .then((value) async {
            final user = UserModel(
                name: '',
                username: usernameController.text,
                email: emailController.text,
                password: passController.text,
                profile:
                    'https://firebasestorage.googleapis.com/v0/b/green-house-app-4828a.appspot.com/o/default%2Fdefault.png?alt=media&token=6589ce94-d767-4fd5-b728-cf1d55fa77d7');
            successSnackBar('Cuenta creada correctamente');
            firestoreService.createUser(user, value.user?.uid);
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

  signUpGoogle(context) async {
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
              profile:
                  'https://firebasestorage.googleapis.com/v0/b/green-house-app-4828a.appspot.com/o/default%2Fdefault.png?alt=media&token=6589ce94-d767-4fd5-b728-cf1d55fa77d7');
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
