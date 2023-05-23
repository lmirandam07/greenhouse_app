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
  TextEditingController profileController = TextEditingController();
  final botomNavBar = BottomNavController();
  final firestoreService = FirestoreService();
  var isLoading = false.obs;
  Map<String, Object> userdata = {};
  Future<dynamic> UpdateUser() async {
    final currentUser =
        await firestoreService.getCurrentUserData().then((value) async {
      if (userNameController.text.isEmpty &&
          nameController.text.isEmpty &&
          profileController.text.isEmpty) {
        userdata = {
          'username': value['username'],
          'name': value['name'],
          'profile': value['profile']
        };
      } else if (nameController.text.isNotEmpty &&
          userNameController.text.isEmpty &&
          profileController.text.isEmpty) {
        userdata = {
          'username': value['username'],
          'name': nameController.text,
          'profile': value['profile'],
        };
      } else if (nameController.text.isEmpty &&
          userNameController.text.isNotEmpty &&
          profileController.text.isEmpty) {
        userdata = {
          'username': userNameController.text,
          'name': value['name'],
          'profile': value['profile'],
        };
      } else if (nameController.text.isEmpty &&
          userNameController.text.isEmpty &&
          profileController.text.isNotEmpty) {
        userdata = {
          'username': value['username'],
          'name': value['name'],
          'profile': profileController.text
        };
      } else if (nameController.text.isEmpty &&
          userNameController.text.isNotEmpty &&
          profileController.text.isNotEmpty) {
        userdata = {
          'username': userNameController.text,
          'name': value['name'],
          'profile': profileController.text
        };
      } else if (nameController.text.isNotEmpty &&
          userNameController.text.isEmpty &&
          profileController.text.isNotEmpty) {
        userdata = {
          'username': value['username'],
          'name': nameController.text,
          'profile': profileController.text
        };
      } else if (nameController.text.isNotEmpty &&
          userNameController.text.isNotEmpty &&
          profileController.text.isEmpty) {
        userdata = {
          'username': userNameController.text,
          'name': nameController.text,
          'profile': value['profile'],
        };
      } else {
        userdata = {
          'username': userNameController.text,
          'name': nameController.text,
          'profile': profileController.text
        };
      }
      try {
        isLoading(true);
        await firestoreService
            .validateUserExist(userNameController.text)
            .then((value) async {
          if (value) {
            errorSnackBar('Ya existe el usuario');
            profileController.clear();
            userNameController.clear();
            nameController.clear();
            isLoading(false);
          } else {
            await firestoreService.UpdateUserData(userdata).then((value) async {
              botomNavBar.profile();
              Get.to(() => BottomNavBar());
              successSnackBar('Perfil actualizado exitosamente');
              profileController.clear();
              userNameController.clear();
              nameController.clear();
              isLoading(false);
            });
          }
        });
      } catch (e) {
        isLoading(false);
      }
    });
  }
}
