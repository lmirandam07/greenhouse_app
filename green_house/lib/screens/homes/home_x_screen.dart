import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/screens/homes/components/emission_box.dart';
import 'package:green_house/screens/homes/home_x_setting_screen.dart';

import '../../widgets/custom_app_bar.dart';

class HomeXScreen extends StatelessWidget {
  const HomeXScreen({Key? key}) : super(key: key);

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
            const CustomAppBar(
              isLeadingIcon: false,
              titleText: 'Hogar X',
            ),

            ///
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// vert dot icon
                    SizedBox(height: screenHeight(context) * 0.024),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: IconButton(
                          onPressed: () {
                            Get.to(HomeXSettingScreen());
                          },
                          icon: SvgPicture.asset(
                            AppIcons.moreVertIcon,
                          ),
                        ),
                      ),
                    ),

                    /// filter icon with chart
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Container(
                          margin: EdgeInsets.only(
                              left: screenHeight(context) * 0.06),
                          height: screenHeight(context) * 0.22,
                          width: screenHeight(context) * 0.22,
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whiteColor,
                            boxShadow: [
                              mainShadow,
                            ],
                          ),
                          child: SvgPicture.asset(AppImages.threePieceImage),
                        ),
                        Container(
                          height: 44.0,
                          width: 44.0,
                          margin: const EdgeInsets.only(right: 16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius10),
                            color: AppColors.primaryColor,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              AppIcons.filterIcon,
                              fit: BoxFit.scaleDown,
                              height: 24.0,
                              width: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///
                    SizedBox(height: screenHeight(context) * 0.02),
                    const EmissionBox(),
                    const EmissionBox(),
                    const EmissionBox(),
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
