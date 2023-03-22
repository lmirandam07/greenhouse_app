import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/screens/homes/homes_screen.dart';
import 'package:green_house/widgets/custom_button.dart';

import '../../widgets/custom_app_bar.dart';

import '../../services/firestore_services/firestore_services.dart';
import '../household/components/activity_item_box.dart';

class HomeEmissionsListScreen extends StatelessWidget {
  final String? homeName;
  final String? homeId;
  HomeEmissionsListScreen(this.homeName, this.homeId);
  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: firestoreService.getUserHomeAcceptedList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  final homesList = snapshot.data;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// top app bar
                      CustomAppBar(
                        isLeadingIcon: false,
                        titleText: homeName,
                      ),

                      /// weight and oxygen box
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              /// recent activity
                              SizedBox(height: screenHeight(context) * 0.02),
                              Container(
                                width: screenWidth(context),
                                margin: EdgeInsets.symmetric(
                                    horizontal: screenHeight(context) * 0.036),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radius10),
                                  color: AppColors.whiteColor,
                                  boxShadow: [
                                    mainShadow,
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: screenWidth(context),
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              screenHeight(context) * 0.02),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(radius10),
                                          topRight: Radius.circular(radius10),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Historial de Emisiones',
                                          style: montserratMedium.copyWith(
                                            fontSize: body20,
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),

                                    /// items
                                    FutureBuilder(
                                        future: firestoreService
                                            .getHomeEmission(homeId),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    LinearProgressIndicator());
                                          }
                                          if (snapshot.hasData &&
                                              snapshot.data.length > 0) {
                                            final homeEmission = snapshot.data;

                                            Color color;
                                            return ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: homeEmission.length,
                                                itemBuilder: (context, index) {
                                                  if (homeEmission[index]
                                                          ['emission_type'] ==
                                                      'power') {
                                                    color =
                                                        AppColors.powerColor;
                                                  } else if (homeEmission[index]
                                                          ['emission_type'] ==
                                                      'transport') {
                                                    color = AppColors.blueColor;
                                                  } else if (homeEmission[index]
                                                          ['emission_type'] ==
                                                      'gas') {
                                                    color = AppColors.gasColor;
                                                  } else {
                                                    color =
                                                        AppColors.trashColor;
                                                  }
                                                  return ActivityItemBox(
                                                      homeEmission[index]
                                                          ['emission_id'],
                                                      homeEmission[index]
                                                          ['emission_title'],
                                                      homeEmission[index]
                                                          ['emission_value'],
                                                      homeEmission[index][
                                                          'emission_register_date'],
                                                      homeEmission[index]
                                                          ['username'],
                                                      color);
                                                });
                                          } else {
                                            return const Center(
                                                child: Text(
                                              'No hay actividad reciente en este hogar',
                                              textAlign: TextAlign.center,
                                            ));
                                          }
                                        }),

                                    SizedBox(
                                        height: screenHeight(context) * 0.02),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /// top app bar
                        CustomAppBar(
                          isLeadingIcon: true,
                          titleText: 'Greenhouse App',
                        ),
                        const Center(
                            child: Padding(
                          padding: EdgeInsets.only(
                              right: 6.0, left: 15.0, top: 175.0, bottom: 10.0),
                          child: Text(
                            'No perteneces a ningún hogar.\nCrea un hogar o acepta alguna invitación para empezar a visualizar los datos',
                            textAlign: TextAlign.center,
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 40.0, right: 40.0, left: 40.0),
                          child: CustomButton(
                              onTap: () {
                                Get.to(HomesScreen());
                              },
                              btnText: 'Crear Hogar'),
                        )
                      ]);
                }
              })),
    );
  }
}
