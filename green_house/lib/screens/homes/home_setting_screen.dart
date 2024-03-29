import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/screens/dialogs/new_member.dart';
import 'package:green_house/widgets/custom_button.dart';
import 'package:green_house/screens/edit_home/edit_home_screen.dart';

import '../../constants/exports.dart';
import '../../services/firestore_services/firestore_services.dart';
import '../../widgets/custom_app_bar.dart';
import 'components/x_setting_box.dart';

class HomeSettingScreen extends StatelessWidget {
  final String homeId;
  final String homeName;
  final String ownerId;
  final firestoreService = FirestoreService();
  HomeSettingScreen(this.homeName, this.homeId, this.ownerId, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// body
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// top app bar
            FutureBuilder(
                future: firestoreService.validateUserOwner(ownerId),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data) {
                    return CustomAppBar(
                      isLeadingIcon: false,
                      titleText: homeName,
                      action: GestureDetector(
                        onTap: () {
                          Get.to(EditHome(homeName, homeId));
                        },
                        child: Container(
                          height: 45.0,
                          width: 45.0,
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
                    );
                  } else {
                    return CustomAppBar(
                      isLeadingIcon: false,
                      titleText: homeName,
                    );
                  }
                }),

            /// members
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight(context) * 0.1),
                    Container(
                      width: screenWidth(context),
                      margin: EdgeInsets.symmetric(
                          horizontal: screenHeight(context) * 0.024),
                      decoration: BoxDecoration(
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
                          Container(
                            width: screenWidth(context),
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight(context) * 0.02),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radius10),
                                topRight: Radius.circular(radius10),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Integrantes',
                                style: montserratMedium.copyWith(
                                  fontSize: body20,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ),

                          /// items
                          SizedBox(height: screenHeight(context) * 0.008),
                          FutureBuilder(
                              future: firestoreService.getHomeUserList(homeId),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                final userList = snapshot.data;
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: userList.length,
                                    itemBuilder: (context, index) {
                                      return XSettingBox(
                                          userList[index]['username'],
                                          userList[index]['email'],
                                          userList[index]['id'],
                                          homeId,
                                          ownerId,
                                          homeName,
                                          userList[index]['profile']);
                                    });
                              }),

                          SizedBox(height: screenHeight(context) * 0.02),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight(context) * 0.032),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenHeight(context) * 0.036,
                      ),
                      child: CustomButton(
                        onTap: () {
                          Get.dialog(NewMemberDialog(homeId));
                        },
                        btnText: 'Nuevo Integrante',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
