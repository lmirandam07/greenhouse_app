import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/screens/auth/login/login_screen.dart';
import 'package:green_house/widgets/custom_snackbar.dart';

class SignupController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  RxBool isPassObscure = true.obs;
  RxBool isConfirmPassObscure = true.obs;
  var isLoading = false.obs;
  var email = '';
  var pass = '';

  Future<dynamic> signUp() async {
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    try {
      isLoading(true);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      )
          .then((value) async {
        successSnackBar('Account created successfully');
        users.add({'email': emailController.text, 'pass': passController.text});
        emailController.clear();
        passController.clear();
        confirmPassController.clear();
        Get.off(LoginScreen());
        isLoading(false);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorSnackBar('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        errorSnackBar('The account already exists for that email.');
      } else {
        errorSnackBar('Something went Wrong, Please try again.');
      }
      isLoading(false);
    }
  }
}
