import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/screens/homes/home_x_screen.dart';

import '../../../constants/exports.dart';

class HomeBox extends StatelessWidget {
  const HomeBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: (){
        Get.to(HomeXScreen());
      },
      child: Container(
        width: screenWidth(context),
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 14.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius10),
          color: AppColors.whiteColor,
          boxShadow: [
            mainShadow,
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 42.0,
              width: 42.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius15),
                color: AppColors.primaryColor,
              ),
              child: Center(
                child: SvgPicture.asset(AppIcons.homeIcon, color: AppColors.whiteColor,),
              ),
            ),
            SizedBox(width: screenHeight(context) * 0.014),
            Expanded(
              child: Text('Nombre de hogar',
                style: montserratRegular.copyWith(
                  fontSize: body17,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            Stack(
              children: [
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: Container(
                    height: 13.0,
                    width: 13.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    child: Center(
                      child: Text('2',
                        style: montserratSemiBold.copyWith(
                          fontSize: body6,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(AppIcons.personGroupIcon),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
