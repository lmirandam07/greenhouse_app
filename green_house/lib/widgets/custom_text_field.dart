import 'package:flutter/material.dart';

import '../constants/exports.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? headText;
  final bool? isHead;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? prefixIconPath;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final EdgeInsets? padding;
  final String? Function(String?)? onSubmitted;

  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.headText,
      required this.hintText,
      this.keyboardType,
      required this.prefixIconPath,
      this.suffixIcon,
      this.obscureText = false,
      this.validator,
      this.isHead = true,
      this.padding,
      this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.symmetric(horizontal: screenHeight(context) * 0.036),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isHead == true
              ? Text(
                  headText!,
                  style: montserratMedium.copyWith(
                    fontSize: body12,
                    color: AppColors.blackColor.withOpacity(0.4),
                  ),
                )
              : const SizedBox(),
          isHead == true ? const SizedBox(height: 4.0) : const SizedBox(),
          SizedBox(
            //height: 50.0,
            child: TextFormField(
              style: montserratRegular.copyWith(
                fontSize: body15,
                color: AppColors.blackMainColor,
              ),
              validator: validator,
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText!,
              onFieldSubmitted: onSubmitted,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius10),
                  borderSide: const BorderSide(
                    color: AppColors.fieldBackColor,
                    width: 0.7,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius10),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 0.7,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius10),
                  borderSide: const BorderSide(
                    color: AppColors.fieldBackColor,
                    width: 0.7,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius10),
                  borderSide: const BorderSide(
                    color: AppColors.redColor,
                    width: 0.7,
                  ),
                ),
                fillColor: AppColors.fieldBackColor,
                filled: true,
                prefixIcon: SvgPicture.asset(
                  prefixIconPath!,
                  height: 15.7,
                  width: 16.2,
                  fit: BoxFit.scaleDown,
                ),
                hintText: hintText,
                hintStyle: montserratRegular.copyWith(
                  fontSize: body14,
                  color: AppColors.blackHintColor,
                ),
                suffixIcon: suffixIcon ?? const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
