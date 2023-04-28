import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
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
  TextEditingController transportTypeController = TextEditingController();
  TextEditingController fuelTypeController = TextEditingController();
  TextEditingController gasSizeController = TextEditingController();
  TextEditingController bagSizeController = TextEditingController();

  final botomNavBar = BottomNavController();
  final firestoreService = FirestoreService();
  var isLoading = false.obs;

  Future<dynamic> createEmissionController(String type) async {
    final user = await firestoreService.getCurrentUserData();
    double co2_value = 0.0;
    // Power multipliers
    double kwh_value = 0.0;
    double fuel_value = 0.0;

    // Transport multipliers
    double time_value = 0.0;
    String title = titleController.text;
    double value = double.parse(valueController.text);
    String home = homeController.text;
    String transport_type = transportTypeController.text;
    String fuel_type = fuelTypeController.text;

    if (type == 'power') {
      kwh_value = value * 0.17;
      co2_value = kwh_value * 0.182;
      co2_value = double.parse(co2_value.toStringAsFixed(2));
    } else if (type == 'transport') {
      if ((fuel_type == '91 octanos' || fuel_type == '95 octanos') &&
          transport_type == 'Vans,Camiones,SUVs') {
        fuel_value = value / 3.25;
        co2_value = fuel_value * 8.792;
      } else if ((fuel_type == 'Diesel') &&
          transport_type == 'Vans,Camiones,SUVs') {
        fuel_value = value / 3.25;
        co2_value = fuel_value * 10.315;
      } else if ((fuel_type == 'Diesel') && transport_type == 'Carro') {
        fuel_value = value / 3.25;
        co2_value = fuel_value * 10.344;
      } else if ((fuel_type == '91 octanos' || fuel_type == '95 octanos') &&
          transport_type == 'Carro') {
        fuel_value = value / 3.25;
        co2_value = fuel_value * 8.798;
      } else if ((fuel_type == '91 octanos' || fuel_type == '95 octanos') &&
          transport_type == 'Motocicleta') {
        fuel_value = value / 3.25;
        co2_value = fuel_value * 8.900;
      }
      co2_value = double.parse(co2_value.toStringAsFixed(2));
    } else if (type == 'gas') {
      int gasSize = int.parse(gasSizeController.text);
      co2_value = (value * gasSize * 6.79) / 5;
      co2_value = double.parse(co2_value.toStringAsFixed(2));
    } else if (type == 'trash') {
      int bagSize = int.parse(bagSizeController.text);
      co2_value = value * ((bagSize * 2.936533191) / 5) * 1.47;
      co2_value = double.parse(co2_value.toStringAsFixed(2));
    }
    try {
      final emission = EmissionModel(
          emission_title: title,
          emission_type: type,
          emission_value: co2_value,
          emission_userId: user['id'],
          emission_homeId: home);
      await firestoreService.createEmission(emission);
      successSnackBar('Emisión creada correctamente');
      titleController.clear();
      valueController.clear();
      homeController.clear();
      bagSizeController.clear();
      gasSizeController.clear();
      botomNavBar.homeFun();
      Get.to(() => BottomNavBar());
      isLoading(false);
    } catch (e) {
      errorSnackBar('Error al crear la casa. Intente nuevamente');
      isLoading(false);
    }
  }
}
