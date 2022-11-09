import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_house/screens/profile/edit_profile_screen.dart';
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
}
