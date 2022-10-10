import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/screens/profile/edit_profile_screen.dart';

import '../../../services/firestore_services/firestore_services.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../bottom/bottom_nav_screen.dart';
import '../../bottom/controller/bottom_nav_controller.dart';
import '../user_profile_screen.dart';

class ProfileController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final botomNavBar = BottomNavController();
  final firestoreService = FirestoreService();
  var isLoading = false.obs;
  Map<String, Object> userdata = {};
  Future<dynamic> UpdateUser() async {
    final currentUser =
        await firestoreService.getCurrentUserData().then((value) async {
      if (userNameController.text.isEmpty && nameController.text.isEmpty) {
        userdata = {'username': value['username'], 'name': value['name']};
      } else if (nameController.text.isEmpty &&
          userNameController.text.isNotEmpty) {
        userdata = {'username': userNameController.text, 'name': value['name']};
      } else if (nameController.text.isNotEmpty &&
          userNameController.text.isEmpty) {
        userdata = {'username': value['username'], 'name': nameController.text};
      } else {
        userdata = {
          'username': userNameController.text,
          'name': nameController.text
        };
      }
      try {
        isLoading(true);
        await firestoreService
            .validateUserExist(userNameController.text)
            .then((value) async {
          if (value) {
            errorSnackBar('Ya existe el usuario');
            isLoading(false);
          } else {
            await firestoreService.UpdateUserData(userdata).then((value) async {
              botomNavBar.profile();
              Get.to(() => const BottomNavBar());
              successSnackBar('Perfil actualizado exitosamente');
              isLoading(false);
            });
          }
        });
      } catch (e) {
        print(e);
        isLoading(false);
      }
    });
  }
}
