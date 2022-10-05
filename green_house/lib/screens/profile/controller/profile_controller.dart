import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/screens/profile/edit_profile_screen.dart';

import '../../../services/firestore_services/firestore_services.dart';
import '../../../widgets/custom_snackbar.dart';
import '../user_profile_screen.dart';

class ProfileController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  final firestoreService = FirestoreService();
  var isLoading = false.obs;
  Future<dynamic> UpdateUser() async {
    final userdata = {'username': userNameController.text};
    if (userdata.isEmpty) {
      Get.back();
    } else {
      try {
        isLoading(true);
        await firestoreService
            .validateUserExist(userNameController.text)
            .then((value) async {
          if (value) {
            errorSnackBar('Ya existe el usuario');
            isLoading(false);
          } else {
            await firestoreService.UpdateUserData(userdata);
            Get.back();
            successSnackBar('Perfil actualizado exitosamente');
            isLoading(false);
          }
        });
      } catch (e) {
        print(e);
        isLoading(false);
      }
    }
  }
}
