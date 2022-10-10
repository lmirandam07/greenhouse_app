import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/screens/profile/edit_profile_screen.dart';

import '../../services/firestore_services/firestore_services.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({Key? key}) : super(key: key);
  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// body
      body: SafeArea(
        child: SizedBox(
          height: screenHeight(context),
          width: screenWidth(context),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// user image
                SizedBox(height: screenHeight(context) * 0.02),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    const SizedBox(),
                    Image.asset(
                      AppImages.avatarImage,
                      height: screenHeight(context) * 0.16,
                    ),
                    Bounceable(
                      onTap: () {
                        Get.to(EditProfileScreen());
                      },
                      child: Container(
                        height: 45.0,
                        width: 45.0,
                        margin: const EdgeInsets.only(right: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius15),
                          color: AppColors.primaryColor,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppIcons.pencilIcon,
                            fit: BoxFit.scaleDown,
                            height: 24.0,
                            width: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// texts
                FutureBuilder(
                    future: firestoreService.getCurrentUserData(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView(shrinkWrap: true, children: <Widget>[
                        Center(
                          child: Text(snapshot.data['username'],
                              style: montserratMedium.copyWith(
                                fontSize: 18.0,
                                color: AppColors.blackColor,
                              )),
                        ),
                        Center(
                          child: Text(snapshot.data['name'],
                              style: montserratMedium.copyWith(
                                fontSize: 14.0,
                                color: AppColors.blackHintColor,
                              )),
                        )
                      ]);
                    }),

                /// graph box
                SizedBox(height: screenHeight(context) * 0.03),
                Container(
                  width: screenWidth(context),
                  margin: EdgeInsets.symmetric(
                    horizontal: screenHeight(context) * 0.032,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(radius10),
                    color: AppColors.whiteColor,
                    boxShadow: [
                      mainShadow,
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///
                      Container(
                        width: screenWidth(context),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight(context) * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radius10),
                            topRight: Radius.circular(radius10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Emisiones por categorias',
                            style: montserratRegular.copyWith(
                              fontSize: body18,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight(context) * 0.02),
                    ],
                  ),
                ),

                /// second box
                SizedBox(height: screenHeight(context) * 0.02),
                Container(
                  width: screenWidth(context),
                  margin: EdgeInsets.symmetric(
                    horizontal: screenHeight(context) * 0.032,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(radius10),
                    color: AppColors.whiteColor,
                    boxShadow: [
                      mainShadow,
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///
                      Container(
                        width: screenWidth(context),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight(context) * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radius10),
                            topRight: Radius.circular(radius10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Historial de emisiones',
                            style: montserratRegular.copyWith(
                              fontSize: body18,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),

                      /// empty box
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          height: 60.0,
                          width: screenWidth(context),
                          margin: EdgeInsets.symmetric(
                              horizontal: screenHeight(context) * 0.03),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius10),
                            color: AppColors.whiteColor,
                            boxShadow: [
                              mainShadow,
                            ],
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          height: 60.0,
                          width: screenWidth(context),
                          margin: EdgeInsets.symmetric(
                              horizontal: screenHeight(context) * 0.03),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius10),
                            color: AppColors.whiteColor,
                            boxShadow: [
                              mainShadow,
                            ],
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight(context) * 0.02),
                    ],
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
