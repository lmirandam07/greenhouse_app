import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants/exports.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'controller/create_home_controller.dart';

class SearchLocationScreen extends StatefulWidget {
  SearchLocationScreen({Key? key}) : super(key: key);

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
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

  final CreateHomeController memberController = Get.put(CreateHomeController());

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

                /// map box
                SizedBox(height: screenHeight(context) * 0.06),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// search loc texts
                      Text(
                        'Seleccionar ubicacion',
                        style: montserratRegular.copyWith(
                          fontSize: 18.0,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      /// field
                      CustomTextField(
                        isHead: false,
                        controller: memberController.searchLocationController,
                        headText: '',
                        hintText: 'Buscar',
                        prefixIconPath: AppIcons.searchIcon,
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      ),

                      /// map
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            Get.back();
                          },
                          btnText: 'Guardar',
                        ),
                      ),
                      SizedBox(width: screenHeight(context) * 0.024),
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
