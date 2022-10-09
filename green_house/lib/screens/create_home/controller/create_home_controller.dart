import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/screens/create_home/create_home_screen.dart';
import 'package:green_house/widgets/custom_snackbar.dart';

import '../../../services/firestore_services/firestore_services.dart';

class CreateHomeController extends GetxController {
  TextEditingController houseHoldNameController = TextEditingController();
  TextEditingController inviteUserController = TextEditingController();
  TextEditingController searchLocationController = TextEditingController();

  final firestoreService = FirestoreService();

  var isLoading = false.obs;

  List invitedUsers = [];

  Future<dynamic> inviteUser() async {
    var user = inviteUserController.text;

    try {
      isLoading(true);
      await firestoreService.validateUserExist(user).then((value) async {
        if (value && !invitedUsers.contains(user)) {
          invitedUsers.add(user);
          successSnackBar("Se agregó al usuario ${user} al hogar");
          inviteUserController.text = "";
          print(invitedUsers);
        } else if (invitedUsers.contains(user)) {
          // Si el usuario ya fue agregado
          errorSnackBar('El usuario ${user} ya fue invitado');
          inviteUserController.text = "";
        } else {
          // Si el usuario no existe en Firebase
          errorSnackBar('El usuario ingresado no existe');
          inviteUserController.text = "";
        }
        isLoading(false);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> createHome() async {}
}
