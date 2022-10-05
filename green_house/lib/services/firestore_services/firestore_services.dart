import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';
import '../../models/home_model.dart';

class FirestoreService {
  //Firebase methods for the user model
  FirestoreService();

  final docUser = FirebaseFirestore.instance.collection('user');
  final docHome = FirebaseFirestore.instance.collection('home');

  createUser(UserModel user, uid) async {
    user.id = docUser.doc(uid).id;
    await docUser.doc(uid).set(user.toJson());
  }

  createHome(HomeModel home) async {
    home.home_id = docHome.id;
    await docHome.doc().set(home.toJson());
  }

  Future<bool> validateUserExist(String username) async {
    final result = await docUser.where('username', isEqualTo: username).get();
    if (result.size > 0) {
      return true;
    } else {
      return false;
    }
  }

  getUserData() async {
    final currentUser = await FirebaseAuth.instance.currentUser?.uid;
    final snapshot = await docUser.doc(currentUser).get();
    final userData = await snapshot.data();
    return userData;
  }

  UpdateUserData(Map<String, Object?> data) async {
    final userData = await getUserData();
    final user = await docUser.doc(userData['id']);
    print(data);
    user.update(data);
  }
}
