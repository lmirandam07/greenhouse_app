import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/screens/dialogs/leave_home.dart';
import 'package:green_house/screens/profile/components/registered_box.dart';
import 'package:green_house/screens/profile/controller/profile_controller.dart';
import 'package:green_house/widgets/custom_button.dart';
import 'package:green_house/widgets/custom_text_field.dart';
import '../../services/firestore_services/firestore_services.dart';
import 'components/profileImageSelector.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  final ProfileController profileController = Get.put(ProfileController());

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
                /// btn
                SizedBox(height: screenHeight(context) * 0.036),
                FutureBuilder(
                    future: firestoreService.getCurrentUserData(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final user = snapshot.data;
                      return ProfileImageSelector(
                        userId: user['id'],
                        currentImageUrl: user['profile'],
                        onImageSelected: (imageUrl) {
                          print('Perfil');
                          profileController.profileController.text = imageUrl;
                        },
                      );
                    }),

                /// field
                SizedBox(height: screenHeight(context) * 0.032),
                CustomTextField(
                  controller: profileController.userNameController,
                  headText: 'Nickname',
                  hintText: 'example',
                  prefixIconPath: AppIcons.userIcon,
                ),

                SizedBox(height: screenHeight(context) * 0.032),
                CustomTextField(
                  controller: profileController.nameController,
                  headText: 'Nombre',
                  hintText: 'example',
                  prefixIconPath: AppIcons.userIcon,
                ),

                /// registered household
                SizedBox(height: screenHeight(context) * 0.032),
                Container(
                  width: screenWidth(context),
                  margin: EdgeInsets.symmetric(
                    horizontal: screenHeight(context) * 0.032,
                  ),
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
                            'Hogares registrados',
                            style: montserratRegular.copyWith(
                              fontSize: body18,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                      FutureBuilder(
                          future: firestoreService.getUserHomeList(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasData) {
                              final homesList = snapshot.data;
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: homesList.length,
                                  itemBuilder: (context, index) {
                                    return HomeSelect(
                                        homeId: homesList[index]['home_id'],
                                        homeName: homesList[index]['home_name'],
                                        ownerId: homesList[index]['owner_id']);
                                  });
                            } else {
                              return const Center(
                                  child: Text('No perteneces a ningún hogar'));
                            }
                          }),

                      SizedBox(height: screenHeight(context) * 0.02),
                    ],
                  ),
                ),

                /// save and discard btn
                SizedBox(height: screenHeight(context) * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            profileController.UpdateUser();
                          },
                          btnText: 'Guardar',
                        ),
                      ),
                      SizedBox(width: screenHeight(context) * 0.02),
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            Get.back();
                          },
                          btnText: 'Descartar',
                        ),
                      ),
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

class HomeSelect extends StatelessWidget {
  final String homeId;
  final String homeName;
  final String ownerId;

  HomeSelect(
      {Key? key,
      required this.homeId,
      required this.homeName,
      required this.ownerId})
      : super(key: key);

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
                child: RegisteredBox(
                    homeName: homeName,
                    onTap: () {
                      Get.dialog(
                        LeaveHomeDialog(homeId: homeId, ownerId: ownerId),
                      );
                    }));
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
