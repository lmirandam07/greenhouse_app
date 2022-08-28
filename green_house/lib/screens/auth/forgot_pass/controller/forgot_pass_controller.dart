import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassController extends GetxController {

  TextEditingController passController = TextEditingController();
  TextEditingController repeatPassController = TextEditingController();

  RxBool passObscure = true.obs;
  RxBool repeatPassObscure = true.obs;

}