import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/screens/homes/homes_screen.dart';
import 'package:green_house/widgets/custom_button.dart';

import '../../widgets/custom_app_bar.dart';
import 'components/activity_item_box.dart';

import '../../services/firestore_services/firestore_services.dart';

class HouseHoldScreen extends StatelessWidget {
  String? homeName;
  String? homeId;
  HouseHoldScreen([this.homeName, this.homeId]);
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

                  if (homeId == null) {
                    homeName = homesList[0]['home_name'];
                    homeId = homesList[0]['home_id'];
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// top app bar
                      CustomAppBar(
                        isLeadingIcon: true,
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
                              SizedBox(height: screenHeight(context) * 0.04),

                              Center(
                                child: Container(
                                  height: screenHeight(context) * 0.23,
                                  width: screenHeight(context) * 0.23,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.whiteColor,
                                    boxShadow: [
                                      mainShadow,
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.whiteColor,
                                      border: Border.all(
                                        width: 12.0,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '45 kg',
                                          style: montserratSemiBold.copyWith(
                                            fontSize: body22,
                                            color: AppColors.blackMainColor,
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'CO',
                                                style: montserratLight.copyWith(
                                                  fontSize: body20,
                                                  color:
                                                      AppColors.blackMainColor,
                                                ),
                                              ),
                                              WidgetSpan(
                                                child: Transform.translate(
                                                  offset:
                                                      const Offset(0.0, 0.0),
                                                  child: Text(
                                                    '2',
                                                    style: montserratRegular
                                                        .copyWith(
                                                      fontSize: body12,
                                                      color: AppColors
                                                          .blackMainColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

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
                                          'Actividad reciente',
                                          style: montserratMedium.copyWith(
                                            fontSize: body20,
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),

                                    /// items
                                    const ActivityItemBox(),
                                    const ActivityItemBox(),
                                    const ActivityItemBox(),
                                    const ActivityItemBox(),

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
