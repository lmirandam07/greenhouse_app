import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/screens/homes/homes_screen.dart';
import 'package:green_house/widgets/custom_button.dart';

import '../../services/firestore_services/firestore_services.dart';
import '../bottom/bottom_nav_screen.dart';
import '../bottom/controller/bottom_nav_controller.dart';
import '../homes/components/x_setting_box.dart';
import '../homes/home_setting_screen.dart';

class RemoveUserDialog extends StatelessWidget {
  final String userId;
  final String username;
  final String homeId;
  final String ownerId;
  final String homeName;
  RemoveUserDialog(
      this.userId, this.username, this.homeId, this.ownerId, this.homeName,
      {Key? key})
      : super(key: key);

  final botomNavBar = BottomNavController();
  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: screenWidth(context),
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          padding: EdgeInsets.symmetric(
              horizontal: screenHeight(context) * 0.024, vertical: 30.0),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(radius10),
            boxShadow: [
              mainShadow,
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Nueva Emisión box
              Container(
                width: screenWidth(context),
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight(context) * 0.02),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(radius10),
                    topLeft: Radius.circular(radius10),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Remover integrante',
                    style: montserratMedium.copyWith(
                      fontSize: 20.0,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                '¿Estás seguro de remover a $username de este hogar?',
                style: montserratRegular.copyWith(
                  fontSize: 16.0,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: screenHeight(context) * 0.04),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: () async {
                        await firestoreService.removeUser(homeId, username);
                        botomNavBar.homeFun();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => BottomNavBar()));
                      },
                      btnText: 'Aceptar',
                    ),
                  ),
                  SizedBox(
                    width: screenHeight(context) * 0.02,
                  ),
                  Expanded(
                    child: CustomButton(
                      onTap: () {
                        Get.back();
                      },
                      btnText: 'Cancelar',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
