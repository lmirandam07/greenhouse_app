import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/screens/invite_member/search_loc_screen.dart';
import 'package:green_house/widgets/custom_button.dart';
import 'package:green_house/widgets/custom_text_field.dart';

import 'controller/invite_member_controller.dart';

class InviteMemberScreen extends StatefulWidget {
  InviteMemberScreen({Key? key}) : super(key: key);

  @override
  State<InviteMemberScreen> createState() => _InviteMemberScreenState();
}

class _InviteMemberScreenState extends State<InviteMemberScreen> {
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        const Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(30.587968, 60.814708),
        ),
      );
    });
  }

  final InviteMemberController memberController =
      Get.put(InviteMemberController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// body
      body: SafeArea(
        child: SizedBox(
          height: screenHeight(context),
          width: screenWidth(context),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// top field
                SizedBox(height: screenHeight(context) * 0.024),
                Padding(
                  padding: EdgeInsets.only(left: screenHeight(context) * 0.032),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.appLogo,
                        height: 70.0,
                        width: 70.0,
                        color: AppColors.primaryColor,
                      ),
                      Expanded(
                        child: CustomTextField(
                          headText: 'Nombre del hogar',
                          hintText: 'johnsondoe',
                          prefixIconPath: AppIcons.userIcon,
                          controller: memberController.houseHoldNameController,
                        ),
                      ),
                    ],
                  ),
                ),

                /// invite member field
                SizedBox(height: screenHeight(context) * 0.04),
                CustomTextField(
                  headText: 'Invitar integrante',
                  hintText: 'johnsondoe',
                  prefixIconPath: AppIcons.userIcon,
                  controller: memberController.inviteUserController,
                ),

                /// btns
                SizedBox(height: screenHeight(context) * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenHeight(context) * 0.032,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: screenHeight(context) * 0.02),
                      Expanded(
                        child: CustomButton(
                          onTap: () {},
                          btnText: 'Enviar',
                        ),
                      ),
                      SizedBox(width: screenHeight(context) * 0.05),
                      Container(
                        height: 45.0,
                        width: 45.0,
                        decoration: BoxDecoration(
                          color: AppColors.fieldBackColor,
                          borderRadius: BorderRadius.circular(radius10),
                        ),
                        child: Center(
                          child: SvgPicture.asset(AppIcons.documentIcon),
                        ),
                      ),
                      SizedBox(width: screenHeight(context) * 0.05),
                    ],
                  ),
                ),

                /// map box
                SizedBox(height: screenHeight(context) * 0.032),
                Container(
                  width: screenWidth(context),
                  padding: const EdgeInsets.all(16.0),
                  margin: EdgeInsets.symmetric(
                      horizontal: screenHeight(context) * 0.032),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius10),
                    color: AppColors.primaryColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextField(
                        isHead: false,
                        controller: memberController.searchLocationController,
                        headText: '',
                        hintText: 'Buscar',
                        prefixIconPath: AppIcons.searchIcon,
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        height: screenHeight(context) * 0.28,
                        width: screenWidth(context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radius10),
                          child: GoogleMap(
                            onMapCreated: _onMapCreated,
                            markers: _markers,
                            initialCameraPosition: const CameraPosition(
                              target: LatLng(30.587968, 60.814708),
                              //zoom: 5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// btn
                const SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenHeight(context) * 0.045,
                  ),
                  child: CustomButton(
                    onTap: () {
                     /// Get.to(SearchLocationScreen());
                      Get.back();
                    },
                    btnText: 'Crear',
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
