import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {

  RxBool analytic = true.obs;
  RxBool home = false.obs;
  RxBool add = false.obs;
  RxBool profile = false.obs;
  RxBool setting = false.obs;

  void analyticFun() {
    analytic.value = true;
    home.value = false;
    add.value = false;
    profile.value = false;
    setting.value = false;
  }

  void homeFun() {
    analytic.value = false;
    home.value = true;
    add.value = false;
    profile.value = false;
    setting.value = false;
  }

  void addFun() {
    analytic.value = false;
    home.value = false;
    add.value = true;
    profile.value = false;
    setting.value = false;
  }

  void profileFun() {
    analytic.value = false;
    home.value = false;
    add.value = false;
    profile.value = true;
    setting.value = false;
  }

  void settingFun() {
    analytic.value = false;
    home.value = false;
    add.value = false;
    profile.value = false;
    setting.value = true;
  }

}
