import 'package:flutter/material.dart';

import '../constants/exports.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? btnText;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        height: 55.0,
        width: screenWidth(context),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(radius8),
          border: Border.all(
            color: AppColors.primaryColor,
            width: 0.7,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius6),
            color: AppColors.primaryColor,
          ),
          child: Center(
            child: Text(
              btnText!,
              style: montserratMedium.copyWith(
                fontSize: 17.0,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
