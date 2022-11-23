import 'package:flutter/material.dart';

import '../../../constants/exports.dart';

class XSettingBox extends StatelessWidget {
  final String userName;
  final String email;
  const XSettingBox(this.userName, this.email, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      margin: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 16.0,
      ),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(radius10),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 1.0,
        ),
        boxShadow: [
          mainShadow,
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 42.0,
            width: 42.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius10),
              color: AppColors.primaryColor,
            ),
            child: Center(
              child: SvgPicture.asset(
                AppIcons.userWhiteIcon,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          SizedBox(width: screenHeight(context) * 0.01),
          Expanded(
            child: Column(
              children: [
                Text(
                  userName,
                  style: montserratRegular.copyWith(
                    fontSize: body15,
                    color: AppColors.blackColor,
                  ),
                ),
                Text(email,
                    style: montserratMedium.copyWith(
                      fontSize: 14.0,
                      color: AppColors.blackHintColor,
                    ))
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 8.0,
                bottom: 8.0,
                right: 8.0,
              ),
              child: SvgPicture.asset(AppIcons.settingIcon),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 8.0,
                bottom: 8.0,
              ),
              child: SvgPicture.asset(AppIcons.deleteIcon),
            ),
          ),
        ],
      ),
    );
  }
}
