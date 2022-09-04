import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';

class UserService {
  final UserModel user;

  UserService(this.user);
  final docUser = FirebaseFirestore.instance.collection('user').doc();
  createUser() async {
    user.id = docUser.id;
    await docUser.set(user.toJson());
  }
}
