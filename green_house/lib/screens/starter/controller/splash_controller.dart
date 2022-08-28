import 'dart:async';

import 'package:get/get.dart';
import 'package:green_house/screens/auth/signup/signup_screen.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Timer(
      const Duration(seconds: 4),
      () => Get.to(
        SignupScreen(),
      ),
    );
  }
}
