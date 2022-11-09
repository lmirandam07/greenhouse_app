import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:green_house/constants/exports.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_house/widgets/custom_button.dart';
import 'package:green_house/widgets/custom_text_field.dart';
import 'package:green_house/services/firestore_services/firestore_services.dart';

import 'controller/edit_home_controller.dart';

class EditHome extends StatefulWidget {
  final String homeId;
  final String homeName;
  EditHome(this.homeName, this.homeId, {Key? key}) : super(key: key);

  @override
  State<EditHome> createState() => _EditHomeState();
}

class _EditHomeState extends State<EditHome> {
  final Set<Marker> _markers = {};
  final _formKey = GlobalKey<FormState>();

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition();
    setState(() {
      editHomeController.setLat = position.latitude;
      editHomeController.setLong = position.longitude;
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

  final firestoreService = FirestoreService();

  final EditHomeController editHomeController = Get.put(EditHomeController());

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
              child: FutureBuilder(
                  future: firestoreService.getHomeData(widget.homeId),
                  builder: (context, AsyncSnapshot snapshot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /// top field
                        SizedBox(height: screenHeight(context) * 0.024),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenHeight(context) * 0.032),
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
                                  headText: 'Nombre de hogar',
                                  hintText:
                                      snapshot.data['home_name'].toString(),
                                  prefixIconPath: AppIcons.homeIcon,
                                  controller: editHomeController
                                      .houseHoldNameController,
                                ),
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
                                    borderRadius:
                                        BorderRadius.circular(radius10),
                                    child: PlacePicker(
                                      apiKey:
                                          "AIzaSyCXI5XhOZrtBHLKGqj_2VLOXjMgOzau4HQ",
                                      initialPosition: LatLng(
                                          snapshot.data['ubication']['lat'],
                                          snapshot.data['ubication']['long']),
                                      autocompleteLanguage: 'es',
                                      region: 'pa',
                                      selectedPlaceWidgetBuilder: (_,
                                          selectedPlace,
                                          state,
                                          isSearchBarFocused) {
                                        editHomeController.setLat =
                                            selectedPlace
                                                ?.geometry?.location.lat;
                                        editHomeController.setLong =
                                            selectedPlace
                                                ?.geometry?.location.lng;
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
                              editHomeController.editHome();
                            },
                            btnText: 'Editar',
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
