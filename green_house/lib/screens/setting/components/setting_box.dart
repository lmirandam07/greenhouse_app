import 'package:flutter/material.dart';

import '../../../constants/exports.dart';

class SettingBox extends StatelessWidget {
  final bool? isSubtitle;
  final VoidCallback? onTap;
  final Widget? suffix;
  final String? titleText;
  final String? subTitleText;
  final String? iconPath;
  final bool? isSvg;
  final Color? iconColor;

  const SettingBox({
    Key? key,
    this.isSubtitle = true,
    required this.onTap,
    this.suffix,
    this.titleText,
    this.subTitleText,
    this.iconPath,
    this.isSvg = true,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        height: 55.0,
        margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 14.0),
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius10),
          color: AppColors.fieldBackColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            isSvg == true ? SvgPicture.asset(iconPath!, color: iconColor) : Image.asset(iconPath!),
            SizedBox(width: screenHeight(context) * 0.015),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    titleText!,
                    style: montserratMedium.copyWith(
                      fontSize: body16,
                      color: AppColors.blackColor,
                    ),
                  ),
                  isSubtitle == true
                      ? Text(
                          subTitleText!,
                          style: montserratRegular.copyWith(
                              fontSize: body12,
                              color: AppColors.blackColor,
                              fontStyle: FontStyle.italic,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            suffix ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
