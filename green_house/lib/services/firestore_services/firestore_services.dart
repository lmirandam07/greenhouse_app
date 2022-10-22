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
        .then((data) => data.docs.single);
    return userData;
  }

  UpdateUserData(Map<String, Object?> data) async {
    final userData = await getCurrentUserData();
    final user = await docUser.doc(userData['id']);
    user.update(data);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserHomes() async {
    final userData = await getCurrentUserData();
    final userHome =
        await docUser.doc(userData['id']).collection('user_homes').get();
    return userHome;
  }

  getUserHomesId() async {
    List userHomesId = [];
    final userHome = await getUserHomes();
    userHome.docs.forEach((homes) {
      userHomesId.add(homes.data()['home_id']);
    });
    return userHomesId;
  }

  Future<Iterable> getUserHomeList() async {
    final userHomesId = await getUserHomesId();
    print(userHomesId);
    final userHomeList =
        await docHome.where('home_id', whereIn: userHomesId).get();
    final userHomeDocs = userHomeList.docs
        .map((doc) => json.decode(json.encode(doc.data())))
        .toList();
    print(userHomeDocs);
    return userHomeDocs;
  }
}
