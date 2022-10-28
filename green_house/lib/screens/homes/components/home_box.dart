import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/screens/homes/home_x_screen.dart';

import '../../../constants/exports.dart';
import '../../../services/firestore_services/firestore_services.dart';

class HomeBox extends StatelessWidget {
  final String homeName;
  final String homeId;
  HomeBox(this.homeName, this.homeId);
  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        Get.to(HomeXScreen());
      },
      child: Container(
        width: screenWidth(context),
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 14.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius10),
          color: AppColors.whiteColor,
          boxShadow: [
            mainShadow,
          ],
        ),
        child: FutureBuilder(
            future: firestoreService.getUserHomeCount(homeId),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (snapshot.data['status'] == 'accepted') ...[
                    Container(
                      height: 42.0,
                      width: 42.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius15),
                        color: AppColors.primaryColor,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppIcons.homeIcon,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ] else ...[
                    Container(
                      height: 42.0,
                      width: 42.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius15),
                        color: AppColors.notifyColor,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppIcons.homeIcon,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(width: screenHeight(context) * 0.014),
                  Expanded(
                    child: Text(
                      homeName,
                      style: montserratRegular.copyWith(
                        fontSize: body17,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      if (snapshot.data['status'] == 'accepted') ...[
                        Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: Container(
                            height: 18.0,
                            width: 18.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                snapshot.data['count'].toString(),
                                style: montserratSemiBold.copyWith(
                                  fontSize: body12,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SvgPicture.asset(AppIcons.personGroupIcon),
                        ),
                      ] else ...[
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Icon(Icons.info_rounded,
                              color: AppColors.notifyColor),
                        ),
                      ],
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}
