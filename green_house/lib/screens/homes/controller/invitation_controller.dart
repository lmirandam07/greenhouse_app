import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/screens/profile/edit_profile_screen.dart';
import '../../../models/home_members.dart';
import '../../../services/firestore_services/firestore_services.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../bottom/bottom_nav_screen.dart';
import '../../bottom/controller/bottom_nav_controller.dart';

class InvitationController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final botomNavBar = BottomNavController();
  final firestoreService = FirestoreService();
  var isLoading = false.obs;
  Future<dynamic> invitationUpdate(String homeId, String status) async {
    try {
      await firestoreService.updateHomeStatus(homeId, status);
    } catch (e) {
      print(e);
      isLoading(false);
    }
  }

  Future<dynamic> invitateUser(String homeId) async {
    String username = userNameController.text;
    bool userExist = await firestoreService.validateUserExist(username);
    if (userExist) {
      final userHomeExist =
          await firestoreService.validateUserHomeExist(homeId, username);
      if (userHomeExist) {
        errorSnackBar('El usuario ingresado ya fue invitado a este hogar');
      } else {
        final userData = await firestoreService.getUserData(username);
        final homeMember = HomeMembersModel(
            member_id: userData['id'],
            member_role: 'common',
            member_status: 'pending');
        await firestoreService.createHomeMembers(homeId, homeMember);
        successSnackBar('El usuario $username fue invitado correctamente');
      }
    } else {
      errorSnackBar('El usuario ingresado no existe');
    }
  }
}
