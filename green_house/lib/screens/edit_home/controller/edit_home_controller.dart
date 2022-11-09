import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_house/models/home_members.dart';
import 'package:green_house/models/home_model.dart';
import 'package:green_house/screens/Edit_home/edit_home_screen.dart';
import 'package:green_house/screens/homes/homes_screen.dart';
import 'package:green_house/widgets/custom_snackbar.dart';

import '../../../services/firestore_services/firestore_services.dart';
import '../../bottom/bottom_nav_screen.dart';
import '../../bottom/controller/bottom_nav_controller.dart';

class EditHomeController extends GetxController {
  TextEditingController houseHoldNameController = TextEditingController();
  TextEditingController searchLocationController = TextEditingController();
  final botomNavBar = BottomNavController();
  double? _lat = 0.0;
  double? _long = 0.0;

  double? get lat => _lat;
  double? get long => _long;

  set setLong(double? long) {
    _long = long;
  }

  set setLat(double? lat) {
    _lat = lat;
  }

  final firestoreService = FirestoreService();

  var isLoading = false.obs;

  Future<dynamic> editHome() async {
    await firestoreService.getCurrentUserData().then((value) async {
      try {
        Map<String, double?> coords = {"lat": lat, "long": long};
        final home = HomeModel(
            home_name: houseHoldNameController.text,
            owner_id: value['id'],
            ubication: coords);
        successSnackBar('Casa editada correctamente');
        houseHoldNameController.clear();
        botomNavBar.homeFun();
        Get.to(() => const BottomNavBar());
        isLoading(false);
      } catch (e) {
        errorSnackBar('Error al editar la casa. Intente nuevamente');
        isLoading(false);
      }
    });
  }
}
