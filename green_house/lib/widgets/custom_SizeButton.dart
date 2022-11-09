import 'package:flutter/material.dart';

import '../constants/exports.dart';

class CustomSizeButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? btnText;
  final double? height;

  const CustomSizeButton({
    Key? key,
    required this.onTap,
    required this.btnText,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 10.0),
        height: height,
        width: 100.0,
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
                fontSize: 15.0,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
