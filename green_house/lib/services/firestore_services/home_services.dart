import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/home_model.dart';

class HomeService {
  final HomeModel home;

  HomeService(this.home);
  final docHome = FirebaseFirestore.instance.collection('home').doc();
  createHome() async {
    home.home_id = docHome.id;
    await docHome.set(home.toJson());
  }
}
