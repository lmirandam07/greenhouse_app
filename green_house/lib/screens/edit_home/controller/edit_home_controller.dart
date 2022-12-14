import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/widgets/custom_snackbar.dart';

import '../../../services/firestore_services/firestore_services.dart';
import '../../bottom/bottom_nav_screen.dart';
import '../../bottom/controller/bottom_nav_controller.dart';

class EditHomeController extends GetxController {
  TextEditingController houseHoldNameController = TextEditingController();
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

  Future<dynamic> editHome(String homeId) async {
    try {
      Map<String, double?> coords = {"lat": lat, "long": long};
      final home_name = houseHoldNameController.text;

      Map<String, dynamic> home_data = {
        'home_name': home_name,
        'ubication': coords
      };

      firestoreService.UpdateHomeData(home_data, homeId);

      successSnackBar('Casa editada correctamente');
      houseHoldNameController.clear();
      botomNavBar.homeFun();
      Get.to(() => BottomNavBar());
      isLoading(false);
    } catch (e) {
      errorSnackBar('Error al editar la casa. Intente nuevamente');
      isLoading(false);
    }
    ;
  }
}
