import 'package:flutter/material.dart';

import '../../../constants/exports.dart';

class EmissionBox extends StatelessWidget {
  const EmissionBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      margin: EdgeInsets.only(
        left: screenHeight(context) * 0.02,
        right: screenHeight(context) * 0.02,
        top: screenHeight(context) * 0.015,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenHeight(context) * 0.014,
        vertical: screenHeight(context) * 0.012,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius10),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Emisiones de “X”',
                  style: montserratRegular.copyWith(
                    fontSize: body15,
                    color: AppColors.blackMainColor,
                  ),
                ),
                SizedBox(height: screenHeight(context) * 0.01),
                Stack(
                  children: [
                    Container(
                      height: 4.0,
                      width: screenWidth(context),
                      color: AppColors.fieldBackColor,
                    ),
                    Container(
                      height: 4.0,
                      width: screenWidth(context) / 2.6,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: screenHeight(context) * 0.015),
          InkWell(
            onTap: () {
              print('a');
            },
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SvgPicture.asset(AppIcons.dropdownArrowIcon),
            ),
          ),
        ],
      ),
    );
  }
}
