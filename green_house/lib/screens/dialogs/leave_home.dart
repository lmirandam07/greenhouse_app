import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/widgets/custom_button.dart';

class LeaveHomeDialog extends StatelessWidget {
  const LeaveHomeDialog({Key? key}) : super(key: key);

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
              Text(
                '¿Deseas salir de este hogar?',
                style: montserratMedium.copyWith(
                  fontSize: body17,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: screenHeight(context) * 0.04),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: () {},
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
