import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/custom_SizeButton.dart';

import '../constants/exports.dart';

import '../../services/firestore_services/firestore_services.dart';
import '../screens/bottom/bottom_nav_screen.dart';
import '../screens/bottom/controller/bottom_nav_controller.dart';
import 'custom_SizeButton.dart';
import '../../screens/household/household_screen.dart';

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
      height: 90,
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
                        children: [
                          FutureBuilder(
                              future: firestoreService.getUserHomeList(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData) {
                                  final homes = snapshot.data;
                                  return Column(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 200,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: homes.length,
                                          itemBuilder: ((context, index) {
                                            return HomeSelect(
                                                homeId: homes[index]['home_id'],
                                                homeName: homes[index]
                                                    ['home_name']);
                                          }),
                                        ),
                                      ),
                                      CustomSizeButton(
                                          onTap: () => Get.back(),
                                          btnText: 'Regresar',
                                          height: 45)
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      const Text(
                                          "No hay casas disponibles para cambiar"),
                                      CustomSizeButton(
                                          onTap: () {
                                            Get.back();
                                          },
                                          btnText: 'Ok',
                                          height: 45.0)
                                    ],
                                  );
                                }
                              })
                        ],
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

class HomeSelect extends StatelessWidget {
  final String homeId;
  final String homeName;
  final botomNavBar = BottomNavController();
  HomeSelect({
    Key? key,
    required this.homeId,
    required this.homeName,
  }) : super(key: key);

  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firestoreService.getUserHomeCount(homeId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: LinearProgressIndicator());
          }
          if (snapshot.data['status'] == 'accepted') {
            return Center(
              child: TextButton(
                  style: TextButton.styleFrom(
                    side: const BorderSide(
                      width: 1.0,
                      color: AppColors.primaryDarkColor,
                    ),
                  ),
                  onPressed: () {
                    botomNavBar.analyticFun();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => BottomNavBar(homeName, homeId)));
                  },
                  child: Center(
                    child: Text(homeName),
                  )),
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
