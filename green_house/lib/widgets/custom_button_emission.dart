import 'package:flutter/material.dart';

import '../constants/exports.dart';

class CustomButtonEmission extends StatelessWidget {
  final VoidCallback? onTap;
  final String? btnText;
  final Color color;

  const CustomButtonEmission(
      {Key? key,
      required this.onTap,
      required this.btnText,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        height: 40.0,
        width: 160,
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(radius8),
          border: Border.all(
            color: color,
            width: 0.7,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius6),
            color: color,
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
