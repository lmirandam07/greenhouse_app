import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/models/emission_model.dart';
import 'package:green_house/screens/profile/edit_profile_screen.dart';
import '../../../models/home_members.dart';
import '../../../services/firestore_services/firestore_services.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../bottom/bottom_nav_screen.dart';
import '../../bottom/controller/bottom_nav_controller.dart';

class EmissionController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  final botomNavBar = BottomNavController();
  final firestoreService = FirestoreService();
  var isLoading = false.obs;

  Future<dynamic> createEmissionController(String type) async {
    final user = await firestoreService.getCurrentUserData();
    String title = titleController.text;
    double value = double.parse(valueController.text);
    String home = homeController.text;
    if (type == 'power') {
      try {
        final emission = EmissionModel(
            emission_title: title,
            emission_type: type,
            emission_value: value,
            emission_userId: user['id'],
            emission_homeId: home);
        await firestoreService.createEmission(emission);
        successSnackBar('Emision creada correctamente');
        titleController.clear();
        valueController.clear();
        homeController.clear();
        botomNavBar.homeFun();
        Get.to(() => BottomNavBar());
        isLoading(false);
      } catch (e) {
        errorSnackBar('Error al crear la casa. Intente nuevamente');
        isLoading(false);
      }
    }
  }
}
