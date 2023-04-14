import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/screens/dialogs/components/dropdown_menu.dart';
import 'package:green_house/screens/dialogs/controller/emission_controller.dart';
import 'package:green_house/widgets/custom_button_emission.dart';

import '../../constants/exports.dart';
import '../../widgets/custom_button.dart';

class ReIssueDialogTrash extends StatelessWidget {
  ReIssueDialogTrash({Key? key}) : super(key: key);

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
                    color: AppColors.trashColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(radius10),
                      topLeft: Radius.circular(radius10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Nueva Emisión de Consumo',
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
                            color: AppColors.trashColor,
                            width: 1.0,
                          ),
                        ),
                        child: TextFormField(
                          controller: emissionController.titleController,
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

                /// Seleccionar one
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
                        child: DropdownMenuC((value) {
                          String _itemSelected;
                          _itemSelected = value as String;
                          emissionController.homeController.text =
                              _itemSelected.split('_')[1];
                        }, AppColors.trashColor),
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
                          'Cantidad de bolsas',
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
                            color: AppColors.trashColor,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: emissionController.valueController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 16.0, bottom: 10.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                'bolsas',
                                style: montserratRegular.copyWith(
                                  fontSize: 12.0,
                                  color: AppColors.trashColor,
                                ),
                              ),
                            ),
                          ],
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
                          'Tamaño de las bolsas',
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
                            color: AppColors.trashColor,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller:
                                    emissionController.bagSizeController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 16.0, bottom: 10.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                'gls',
                                style: montserratRegular.copyWith(
                                  fontSize: 12.0,
                                  color: AppColors.trashColor,
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
                Center(
                    child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CustomButtonEmission(
                          onTap: () {
                            Get.back();
                          },
                          btnText: 'Cancelar',
                          color: AppColors.trashColor,
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CustomButtonEmission(
                          onTap: () {
                            emissionController
                                .createEmissionController('trash');
                          },
                          btnText: 'Registrar',
                          color: AppColors.trashColor,
                        ))
                  ],
                )),

                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
