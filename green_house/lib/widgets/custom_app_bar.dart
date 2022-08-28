import 'package:flutter/material.dart';
import 'package:green_house/constants/shadows.dart';

import '../constants/exports.dart';

class CustomAppBar extends StatelessWidget {
  final bool? isLeadingIcon;
  final String? titleText;
  final Widget? action;

  const CustomAppBar({
    Key? key,
    this.isLeadingIcon = false,
    required this.titleText,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: screenWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(radius30),
          bottomLeft: Radius.circular(radius30),
        ),
        boxShadow: [
          whiteLightShadow,
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isLeadingIcon == true
              ? Bounceable(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: AppColors.primaryDarkColor,
                      borderRadius: BorderRadius.circular(radius15),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppIcons.homeIcon),
                        const SizedBox(width: 6.0),
                        SvgPicture.asset(AppIcons.dropdownIcon),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
          isLeadingIcon == true
              ? SizedBox(width: screenHeight(context) * 0.036)
              : const SizedBox(),
          Text(
            titleText!,
            style: montserratMedium.copyWith(
              fontSize: body20,
              color: AppColors.blackColor,
            ),
          ),
          const Spacer(),
          action ?? const SizedBox(),
        ],
      ),
    );
  }
}
