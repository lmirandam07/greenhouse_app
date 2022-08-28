import 'package:flutter/material.dart';

import '../constants/exports.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback? onTap;

  const GoogleButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenHeight(context) * 0.036),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius8),
          child: Ink(
            height: 55.0,
            width: screenWidth(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius8),
              border: Border.all(
                color: AppColors.greyDarkColor,
                width: 1.0,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcons.googleIcon),
                const SizedBox(width: 14.0),
                Text('Google',
                  style: montserratRegular.copyWith(
                    fontSize: 14.0,
                    color: AppColors.blackMainColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
