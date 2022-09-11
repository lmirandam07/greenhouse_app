import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/screens/homes/components/home_box.dart';
import 'package:green_house/screens/create_home/create_home_screen.dart';

import '../../widgets/custom_app_bar.dart';

class HomesScreen extends StatelessWidget {
  const HomesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// top app bar
            CustomAppBar(
              isLeadingIcon: false,
              titleText: 'Hogares',
              action: GestureDetector(
                onTap: () {
                  Get.to(CreateHomeScreen());
                },
                child: Container(
                  height: 45.0,
                  width: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius15),
                    color: AppColors.primaryColor,
                  ),
                  child: const Center(
                    child: Icon(Icons.add,
                        color: AppColors.blackColor, size: 30.0),
                  ),
                ),
              ),
            ),

            /// list
            SizedBox(height: screenHeight(context) * 0.016),
            const HomeBox(),
            const HomeBox(),
          ],
        ),
      ),
    );
  }
}
