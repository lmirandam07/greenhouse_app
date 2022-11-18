import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/shadows.dart';

import '../constants/exports.dart';

import '../../services/firestore_services/firestore_services.dart';

class CustomAppBar extends StatelessWidget {
  final bool? isLeadingIcon;
  final String? titleText;
  final Widget? action;

  CustomAppBar({
    Key? key,
    this.isLeadingIcon = false,
    required this.titleText,
    this.action,
  }) : super(key: key);

  final firestoreService = FirestoreService();

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
                  onTap: () {
                    Get.defaultDialog(
                      title: "Seleccionar Hogar",
                      buttonColor: AppColors.primaryDarkColor,
                      content: Column(
                        children: [FutureBuilder(
                  future: firestoreService.getUserHomeList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Text("A"); 
                  })],
                      ),
                    );
                  },
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
