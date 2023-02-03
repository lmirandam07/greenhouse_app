import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/screens/homes/components/emission_box.dart';
import 'package:green_house/screens/homes/home_setting_screen.dart';
import '../../services/firestore_services/firestore_services.dart';
import '../../widgets/custom_app_bar.dart';
import '../../charts/pie_chart.dart';

class HomeScreen extends StatelessWidget {
  final String homeId;
  final String homeName;
  final String ownerId;
  HomeScreen(this.homeName, this.homeId, this.ownerId, {Key? key})
      : super(key: key);
  final firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// body
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// top app bar
            FutureBuilder(
                future: firestoreService.validateUserOwner(ownerId),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data) {
                    return CustomAppBar(
                        isLeadingIcon: false,
                        titleText: homeName,
                        action: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: IconButton(
                              onPressed: () {
                                Get.to(HomeSettingScreen(
                                    homeName, homeId, ownerId));
                              },
                              icon: SvgPicture.asset(AppIcons.settingIcon),
                            ),
                          ),
                        ));
                  } else {
                    return CustomAppBar(
                        isLeadingIcon: false, titleText: homeName);
                  }
                }),

            ///
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// vert dot icon
                    SizedBox(height: screenHeight(context) * 0.024),

                    /// filter icon with chart
                    Container(
                      height: screenHeight(context) * 0.22,
                      width: screenHeight(context) * 0.22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.whiteColor,
                        boxShadow: [
                          mainShadow,
                        ],
                      ),
                      child: FutureBuilder(
                          future:
                              firestoreService.homeEmissionTotalByType(homeId),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            final emissionTotals = snapshot.data;
                            return PieChartWidget(emissionTotals);
                          }),
                    ),

                    ///
                    SizedBox(height: screenHeight(context) * 0.02),

                    FutureBuilder(
                        future:
                            firestoreService.getHomeUserEmissionList(homeId),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: LinearProgressIndicator());
                          }
                          final data = snapshot.data;
                          return EmissionBox(homeId);
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
