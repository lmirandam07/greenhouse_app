import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_house/models/home_members.dart';

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

  createHome(HomeModel home, List<HomeMembersModel> members) async {
    home.home_id = docHome.doc().id;
    await docHome.doc(home.home_id).set(home.toJson()).whenComplete(() {
      members.forEach((member) {
        createHomeMembers(home.home_id, member);
      });
    });
  }

  createHomeMembers(String home_id, HomeMembersModel member) async {
    await docHome
        .doc(home_id)
        .collection('home_members')
        .doc(member.member_id)
        .set(member.toJson());
    await docUser
        .doc(member.member_id)
        .collection('user_homes')
        .doc(home_id)
        .set({'home_id': home_id, 'home_status': member.member_status});
  }

  Future<bool> validateUserExist(String username) async {
    final result = await docUser.where('username', isEqualTo: username).get();
    if (result.size > 0) {
      return true;
    } else {
      return false;
    }
  }

  getCurrentUserData() async {
    final currentUser = await FirebaseAuth.instance.currentUser?.uid;
    final snapshot = await docUser.doc(currentUser).get();
    final userData = await snapshot.data();
    return userData;
  }

  getUserData(String username) async {
    final userData = await docUser
        .where('username', isEqualTo: username)
        .get()
        .then((data) => data.docs.first);
    return userData;
  }

  UpdateUserData(Map<String, Object?> data) async {
    final userData = await getCurrentUserData();
    final user = await docUser.doc(userData['id']);
    user.update(data);
  }

  getUserHomes() async {
    List homeDocs = [];
    final userData = await getCurrentUserData();
    print('Usario 1 ' + userData['id']);
    final homeSnapshot = await docUser
        .doc(userData['id'])
        .collection('user_homes')
        .get()
        .then((value) async {
      value.docs
          .map((doc) => json.decode(json.encode(doc.data())))
          .toList()
          .forEach((userHome) async {
        await docHome.doc(userHome['home_id']).get().then((home) async {
          homeDocs.add(home.data());
          print(homeDocs);
        }).whenComplete(() {
          print('Usario 2 ' + userData['id']);
          print('Fin ' + homeDocs.toString());
          return homeDocs;
        });
      });
    });
    print('bject');
    // yield homes;
  }
}
