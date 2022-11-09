import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/widgets/custom_button.dart';

import '../../constants/exports.dart';
import '../../services/firestore_services/firestore_services.dart';
import '../../widgets/custom_SizeButton.dart';
import '../bottom/bottom_nav_screen.dart';
import '../bottom/controller/bottom_nav_controller.dart';

class HomeInvitation extends StatelessWidget {
  final String homeId;
  HomeInvitation(this.homeId, {Key? key}) : super(key: key);
  final firestoreService = FirestoreService();
  final botomNavBar = BottomNavController();

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
            child: FutureBuilder(
                future: firestoreService.getHomeData(homeId),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(
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
                            'Nueva Invitación',
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
                              child: Column(
                                children: [
                                  Text(
                                    '${snapshot.data['username']} te está invitando al hogar  ${snapshot.data['home_name']}',
                                    style: montserratRegular.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.blackColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '¿Deseas unirte a este hogar?',
                                    style: montserratRegular.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Seleccionar one

                      ///

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomSizeButton(
                              onTap: () async {
                                await firestoreService
                                    .updateHomeStatus(homeId, 'accepted')
                                    .then((value) {
                                  botomNavBar.homeFun();
                                  Get.to(() => const BottomNavBar());
                                });
                              },
                              btnText: 'Aceptar',
                              height: 45.0,
                            ),
                            CustomSizeButton(
                              onTap: () async {
                                await firestoreService
                                    .updateHomeStatus(homeId, 'denied')
                                    .then((value) {
                                  botomNavBar.homeFun();
                                  Get.to(() => const BottomNavBar());
                                });
                              },
                              btnText: 'Rechazar',
                              height: 45.0,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20.0),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
