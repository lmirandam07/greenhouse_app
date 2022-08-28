import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../../constants/exports.dart';

class RegisteredBox extends StatelessWidget {

  final VoidCallback? onTap;

  const RegisteredBox({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      margin: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 14.0,
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
                AppIcons.homeIcon,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          SizedBox(width: screenHeight(context) * 0.01),
          Expanded(
            child: Text(
              'Nombre de integrante',
              style: montserratRegular.copyWith(
                fontSize: body15,
                color: AppColors.blackColor,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  top: 8.0,
                  bottom: 8.0,
                  right: 8.0,
                ),
                child: SvgPicture.asset(AppIcons.logoutIcon) ,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
