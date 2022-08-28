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
  var isLoading=false.obs;

  signIn() async {
    try {
      isLoading(true);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      ).then((value) async {
        successSnackBar('LoggedIn successfully');
        emailController.clear();
        passController.clear();
        Get.offAll(BottomNavBar());
        isLoading(false);
      });
    }on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found') {
        errorSnackBar('No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        errorSnackBar('Wrong password provided for that user.');
      }else{
        errorSnackBar('Something went Wrong, Please try again.');
      }
      isLoading(false);
    }

  }

}
