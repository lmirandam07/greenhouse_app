import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/screens/dialogs/components/dropdown_transport_menu.dart';
import 'package:green_house/screens/dialogs/components/dropdown_menu.dart';
import 'package:green_house/widgets/custom_button_emission.dart';

import '../../constants/exports.dart';
import 'controller/emission_controller.dart';

class ReIssueDialogTransport extends StatelessWidget {
  ReIssueDialogTransport({Key? key}) : super(key: key);

  final EmissionController emissionController = Get.put(EmissionController());


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Container(
            width: screenWidth(context),
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    color: AppColors.blueColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(radius10),
                      topLeft: Radius.circular(radius10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Nueva Emisión de Movilización',
                      style: montserratMedium.copyWith(
                        fontSize: 20.0,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                /// Título de emisión
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Título de emisión',
                          style: montserratRegular.copyWith(
                            fontSize: 16.0,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      Container(
                        height: 40.0,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius10),
                          color: AppColors.whiteColor,
                          border: Border.all(
                            color: AppColors.blueColor,
                            width: 1.0,
                          ),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 16.0, bottom: 10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Tipo de transporte',
                          style: montserratRegular.copyWith(
                            fontSize: 16.0,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      Container(
                        height: 40.0,
                        width: 150,
                        child: DropdownTransportMenu((value) {
                          String _itemSelected;
                          _itemSelected = value as String;
                        }, AppColors.blueColor),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Seleccionar',
                          style: montserratRegular.copyWith(
                            fontSize: 16.0,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      Container(
                        height: 40.0,
                        width: 150,
                        child: DropdownMenu((value) {
                          String _itemSelected;
                          _itemSelected = value as String;
                          emissionController.homeController.text =
                              _itemSelected.split('_')[1];
                        }, AppColors.blueColor),
                      ),
                    ],
                  ),
                ),

                /// Título de emisión
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Monto',
                          style: montserratRegular.copyWith(
                            fontSize: 16.0,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      Container(
                        height: 40.0,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius10),
                          color: AppColors.whiteColor,
                          border: Border.all(
                            color: AppColors.blueColor,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                '\$',
                                style: montserratRegular.copyWith(
                                  fontSize: 17.0,
                                  color: AppColors.blueColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 16.0, bottom: 10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                ///
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomButtonEmission(
                    color: AppColors.blueColor,
                    onTap: () {
                      Get.back();
                    },
                    btnText: 'Registrar',
                  ),
                ),

                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
