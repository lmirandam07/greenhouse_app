import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/screens/auth/login/login_screen.dart';
import 'package:green_house/screens/setting/controller/setting_controller.dart';

import '../../services/firestore_services/firestore_services.dart';
import 'components/setting_box.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  final SettingController settingController = Get.put(SettingController());
  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// body
      body: SafeArea(
        child: SizedBox(
          height: screenHeight(context),
          width: screenWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight(context) * 0.04),

              /// measurement box

              /// language box
              SettingBox(
                onTap: null,
                titleText: 'Notificaciones',
                iconPath: AppIcons.notificationIcon,
                subTitleText: 'Activar',
                suffix: Obx(() {
                  return FlutterSwitch(
                    width: 48.0,
                    height: 26.0,
                    toggleSize: 20.0,
                    activeColor: AppColors.primaryColor,
                    inactiveColor: AppColors.blackMainColor.withOpacity(0.6),
                    value: settingController.status.value,
                    borderRadius: 30.0,
                    padding: 3.0,
                    showOnOff: false,
                    onToggle: (val) {
                      settingController.status.value =
                          !settingController.status.value;
                      firestoreService.setNotification(val);
                    },
                  );
                }),
              ),

              /// mode box

              /// session out box
              SettingBox(
                onTap: () {
                  Get.offAll(LoginScreen());
                },
                isSubtitle: false,
                titleText: 'Cerrar Sesion',
                iconPath: AppIcons.logoutIcon,
                iconColor: AppColors.blackColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
