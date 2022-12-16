import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/screens/dialogs/emission_power_dialog.dart';
import 'package:green_house/screens/dialogs/emission_transport_dialog.dart';

import '../homes/homes_screen.dart';
import '../household/household_screen.dart';
import '../profile/user_profile_screen.dart';
import '../setting/setting_screen.dart';
import 'controller/bottom_nav_controller.dart';

class BottomNavBar extends GetView<BottomNavController> {
  String? homeName;
  String? homeId;
  BottomNavBar([this.homeName, this.homeId]);

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavController());
    return Scaffold(
      /// floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Transform.rotate(
        angle: 45,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0, right: 40),
          child: FloatingActionButton(
            onPressed: () {
              Get.dialog(ReIssueDialogTransport());
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius15),
            ),
            backgroundColor: AppColors.whiteColor,
            child: Container(
              height: 42.0,
              width: 42.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius10),
                color: AppColors.primaryColor,
              ),
              child: Center(
                child: Transform.rotate(
                  angle: 90.1,
                  child: const Icon(
                    Icons.add,
                    color: AppColors.whiteColor,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      extendBody: true,

      /// body
      body: Obx(
        () {
          return Column(
            children: [
              Expanded(
                child: controller.analytic.value == true
                    ? HouseHoldScreen(homeName, homeId)
                    : controller.home.value == true
                        ? HomesScreen()
                        : controller.profile.value == true
                            ? UserProfileScreen()
                            : controller.setting.value == true
                                ? SettingScreen()
                                : const SizedBox(),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 12.0),
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 15.0),
                alignment: Alignment.bottomCenter,
                width: screenWidth(context),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(radius10),
                  boxShadow: [
                    mainShadow,
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Bounceable(
                      onTap: () {
                        controller.analyticFun();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(9.0),
                        decoration: BoxDecoration(
                          color: controller.analytic.value == true
                              ? AppColors.greyColor.withOpacity(0.5)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radius10),
                        ),
                        child: SvgPicture.asset(
                          AppIcons.vectorLineIcon,
                          height: 24.0,
                          width: 24.0,
                          fit: BoxFit.fill,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    Bounceable(
                      onTap: () {
                        controller.homeFun();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(9.0),
                        decoration: BoxDecoration(
                          color: controller.home.value == true
                              ? AppColors.greyColor.withOpacity(0.5)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radius10),
                        ),
                        child: SvgPicture.asset(
                          AppIcons.homeIcon,
                          height: 24.0,
                          width: 24.0,
                          fit: BoxFit.fill,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(),
                    const SizedBox(),
                    Bounceable(
                      onTap: () {
                        controller.profileFun();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(9.0),
                        decoration: BoxDecoration(
                          color: controller.profile.value == true
                              ? AppColors.greyColor.withOpacity(0.5)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radius10),
                        ),
                        child: SvgPicture.asset(
                          AppIcons.userWhiteIcon,
                          height: 24.0,
                          width: 24.0,
                          fit: BoxFit.fill,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    Bounceable(
                      onTap: () {
                        controller.settingFun();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(9.0),
                        decoration: BoxDecoration(
                          color: controller.setting.value == true
                              ? AppColors.greyColor.withOpacity(0.5)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radius10),
                        ),
                        child: SvgPicture.asset(
                          AppIcons.settingIcon,
                          height: 24.0,
                          width: 24.0,
                          fit: BoxFit.fill,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
