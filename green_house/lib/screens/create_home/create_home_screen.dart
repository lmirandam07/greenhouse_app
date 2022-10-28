import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:green_house/constants/exports.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_house/widgets/custom_button.dart';
import 'package:green_house/widgets/custom_text_field.dart';

import 'controller/create_home_controller.dart';

class CreateHomeScreen extends StatefulWidget {
  CreateHomeScreen({Key? key}) : super(key: key);

  @override
  State<CreateHomeScreen> createState() => _CreateHomeScreenState();
}

class _CreateHomeScreenState extends State<CreateHomeScreen> {
  final Set<Marker> _markers = {};
  final _formKey = GlobalKey<FormState>();

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition();
    print(position);

    setState(() {
      createHomeController.setLat = position.latitude;
      createHomeController.setLong = position.longitude;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _getUserLocation();
      _markers.add(
        const Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(8.9972, -79.5068),
        ),
      );
    });
  }

  final CreateHomeController createHomeController =
      Get.put(CreateHomeController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
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
                    padding:
                        EdgeInsets.only(left: screenHeight(context) * 0.032),
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
                            hintText: 'Hogar',
                            prefixIconPath: AppIcons.homeIcon,
                            controller:
                                createHomeController.houseHoldNameController,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// invite member field
                  SizedBox(height: screenHeight(context) * 0.04),
                  Padding(
                    padding:
                        EdgeInsets.only(left: screenHeight(context) * 0.032),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            headText: 'Invitar integrante',
                            hintText: 'username',
                            prefixIconPath: AppIcons.userIcon,
                            controller:
                                createHomeController.inviteUserController,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: screenHeight(context) * 0.032,
                              top: screenHeight(context) * 0.030),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(screenWidth(context) * 0.020,
                                      screenHeight(context) * 0.010)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  createHomeController.inviteUser();
                                }
                              },
                              child: const Icon(
                                // <-- Icon
                                Icons.send,
                                size: 24.0,
                              )),
                        ),
                      ],
                    ),
                  ),

                  /// btns
                  SizedBox(height: screenHeight(context) * 0.02),

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
                        const SizedBox(height: 16.0),
                        Container(
                          height: screenHeight(context) * 0.45,
                          width: screenWidth(context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius10),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(radius10),
                              child: PlacePicker(
                                apiKey:
                                    "AIzaSyCXI5XhOZrtBHLKGqj_2VLOXjMgOzau4HQ",
                                initialPosition: const LatLng(8.9972, -79.5068),
                                useCurrentLocation: true,
                                autocompleteLanguage: 'es',
                                region: 'pa',
                                selectedPlaceWidgetBuilder: (_, selectedPlace,
                                    state, isSearchBarFocused) {
                                  createHomeController.setLat =
                                      selectedPlace?.geometry?.location.lat;
                                  createHomeController.setLong =
                                      selectedPlace?.geometry?.location.lng;
                                  return const SizedBox.shrink();
                                },
                              )),
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
                        createHomeController.createHome();
                      },
                      btnText: 'Crear',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
