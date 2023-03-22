import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/screens/homes/homes_screen.dart';
import 'package:green_house/widgets/custom_button.dart';

import '../../services/firestore_services/firestore_services.dart';
import '../../widgets/custom_button_emission.dart';
import '../bottom/bottom_nav_screen.dart';
import '../bottom/controller/bottom_nav_controller.dart';
import '../homes/components/x_setting_box.dart';
import '../homes/home_setting_screen.dart';

class RemoveUserDialog extends StatelessWidget {
  final String emissionId;
  final String emissionTitle;
  final Color color;
  RemoveUserDialog(this.emissionId, this.emissionTitle, this.color, {Key? key})
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
              horizontal: screenHeight(context) * 0.014, vertical: 10.0),
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
                  color: color,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(radius10),
                    topLeft: Radius.circular(radius10),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Eliminar Emisión',
                    style: montserratMedium.copyWith(
                      fontSize: 20.0,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                '¿Estás seguro de eliminar la emisión de título "$emissionTitle" de este hogar?',
                style: montserratRegular.copyWith(
                  fontSize: 16.0,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: screenHeight(context) * 0.04),
              Row(
                children: [
                  Expanded(
                    child: CustomButtonEmission(
                      onTap: () async {
                        await firestoreService.deleteEmission(emissionId);
                        botomNavBar.homeFun();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => BottomNavBar()));
                      },
                      btnText: 'Aceptar',
                      color: color,
                    ),
                  ),
                  SizedBox(
                    width: screenHeight(context) * 0.02,
                  ),
                  Expanded(
                    child: CustomButtonEmission(
                      onTap: () {
                        Get.back();
                      },
                      btnText: 'Cancelar',
                      color: color,
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
