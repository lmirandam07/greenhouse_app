import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_house/models/home_members.dart';
import 'package:green_house/models/home_model.dart';
import 'package:green_house/screens/create_home/create_home_screen.dart';
import 'package:green_house/screens/homes/homes_screen.dart';
import 'package:green_house/widgets/custom_snackbar.dart';

import '../../../services/firestore_services/firestore_services.dart';
import '../../bottom/bottom_nav_screen.dart';
import '../../bottom/controller/bottom_nav_controller.dart';

class CreateHomeController extends GetxController {
  TextEditingController houseHoldNameController = TextEditingController();
  TextEditingController inviteUserController = TextEditingController();
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

  List invitedUsers = [];
  List<HomeMembersModel> inviteUserModel = [];

  Future<dynamic> inviteUser() async {
    var user = inviteUserController.text;

    try {
      isLoading(true);
      await firestoreService.validateUserExist(user).then((value) async {
        if (value && !invitedUsers.contains(user)) {
          invitedUsers.add(user);
          successSnackBar("Se agregó al usuario ${user} al hogar");
          inviteUserController.text = "";
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

  Future<dynamic> createHome() async {
    await firestoreService.getCurrentUserData().then((value) async {
      try {
        Map<String, double?> coords = {"lat": lat, "long": long};
        final home = HomeModel(
            home_name: houseHoldNameController.text,
            owner_id: value['id'],
            activated: true,
            ubication: coords);
        final homeOwner = HomeMembersModel(
            member_id: value['id'],
            member_role: 'Owner',
            member_status: 'accepted');
        inviteUserModel.add(homeOwner);
        invitedUsers.forEach((user) async {
          await firestoreService.getUserData(user).then((value) async {
            final homeMember = HomeMembersModel(
                member_id: value['id'],
                member_role: 'common',
                member_status: 'pending');
            inviteUserModel.add(homeMember);
          });
        });
        await firestoreService.createHome(home, inviteUserModel);
        successSnackBar('Casa creada correctamente');
        houseHoldNameController.clear();
        inviteUserController.clear();
        botomNavBar.homeFun();
        Get.to(() => BottomNavBar());
        isLoading(false);
      } catch (e) {
        errorSnackBar('Error al crear la casa. Intente nuevamente');
        isLoading(false);
      }
    });
  }
}
