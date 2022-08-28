import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/exports.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      backgroundColor: AppColors.primaryColor,

      /// body
      body: Stack(
        children: [
          Center(
            child: Transform.scale(
              scale: 1.4,
              child: Container(
                padding: EdgeInsets.all(screenHeight(context) * 0.065),
                height: screenHeight(context) * 0.75,
                width: screenHeight(context) * 0.75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.whiteColor.withOpacity(0.1),
                ),
                child: Container(
                  padding: EdgeInsets.all(screenHeight(context) * 0.06),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.whiteColor.withOpacity(0.15),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(screenHeight(context) * 0.054),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.whiteColor.withOpacity(0.20),
                    ),
                    child: Image.asset(AppImages.appLogo),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
