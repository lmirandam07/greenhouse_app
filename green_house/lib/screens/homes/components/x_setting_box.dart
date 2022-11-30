import 'package:flutter/material.dart';
import 'package:green_house/screens/dialogs/user_pending.dart';

import '../../../constants/exports.dart';
import '../../../services/firestore_services/firestore_services.dart';
import '../../dialogs/remove_user.dart';
import 'package:get/get.dart';

class XSettingBox extends StatelessWidget {
  final String userName;
  final String email;
  final String userId;
  final String homeId;
  final String ownerId;
  final String homeName;
  XSettingBox(this.userName, this.email, this.userId, this.homeId, this.ownerId,
      this.homeName,
      {Key? key})
      : super(key: key);

  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firestoreService.userHomeStatus(homeId, userId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LinearProgressIndicator());
          }
          final bool status = snapshot.data;
          if (status) {
            return Container(
                width: screenWidth(context),
                margin: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: 16.0,
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
                          AppIcons.userWhiteIcon,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(width: screenHeight(context) * 0.01),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            userName,
                            style: montserratRegular.copyWith(
                              fontSize: body15,
                              color: AppColors.blackColor,
                            ),
                          ),
                          Text(email,
                              style: montserratMedium.copyWith(
                                fontSize: 14.0,
                                color: AppColors.blackHintColor,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 35,
                      child: FutureBuilder(
                          future: firestoreService.validateUserOwner(userId),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: LinearProgressIndicator());
                            }
                            if (!snapshot.data) {
                              return InkWell(
                                onTap: () {
                                  Get.dialog(RemoveUserDialog(userId, userName,
                                      homeId, ownerId, homeName));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    top: 8.0,
                                    bottom: 8.0,
                                  ),
                                  child: SvgPicture.asset(AppIcons.deleteIcon),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
                    ),
                  ],
                ));
          } else {
            return Container(
                width: screenWidth(context),
                margin: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: 16.0,
                ),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(radius10),
                  border: Border.all(
                    color: AppColors.notifyColor,
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
                        color: AppColors.notifyColor,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppIcons.userWhiteIcon,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(width: screenHeight(context) * 0.01),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            userName,
                            style: montserratRegular.copyWith(
                              fontSize: body15,
                              color: AppColors.blackColor,
                            ),
                          ),
                          Text(email,
                              style: montserratMedium.copyWith(
                                fontSize: 14.0,
                                color: AppColors.blackHintColor,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 35,
                      child: InkWell(
                        onTap: () {
                          Get.dialog(UserPendingDialog(userName));
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(
                            left: 8.0,
                            top: 8.0,
                            bottom: 8.0,
                          ),
                          child: Icon(
                            Icons.info,
                            color: AppColors.notifyColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          }
        });
  }
}
