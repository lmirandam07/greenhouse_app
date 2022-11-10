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

  UpdateHomeData(Map<String, Object?> data, homeId) async {
    final home = await docHome.doc(homeId);
    home.update(data);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserHomes() async {
    final userData = await getCurrentUserData();
    final userHome =
        await docUser.doc(userData['id']).collection('user_homes').get();
    return userHome;
  }

  Future<List> getUserHomesId() async {
    List userHomesId = [];
    final userHome = await getUserHomes();
    userHome.docs.forEach((homes) {
      userHomesId.add(homes.data()['home_id']);
    });
    return userHomesId;
  }

  Future<Map<String, dynamic>> getUserHomeCount(String homeId) async {
    final userData = await getCurrentUserData();
    final userDocs = await docHome
        .doc(homeId)
        .collection('home_members')
        .where('member_status', isEqualTo: 'accepted')
        .get();
    final userCount = userDocs.docs.length;
    final userDoc = await docHome
        .doc(homeId)
        .collection('home_members')
        .doc(userData['id'])
        .get();

    final userStatus = userDoc.data()?['member_status'];
    final Map<String, dynamic> userHomeData = {
      'count': userCount,
      'status': userStatus
    };
    return userHomeData;
  }

  Future<Iterable> getUserHomeList() async {
    final userHomesId = await getUserHomesId();
    final userHomeList =
        await docHome.where('home_id', whereIn: userHomesId).get();
    final userHomeDocs = userHomeList.docs
        .map((doc) => json.decode(json.encode(doc.data())))
        .toList();
    return userHomeDocs;
  }

  getHomeData(String homeId) async {
    final snapshot = await docHome.doc(homeId).get();
    final homeData = snapshot.data();
    final snapshotOwner = await docUser.doc(homeData?['owner_id']).get();
    final ownerData = snapshotOwner.data();
    final data = {...?homeData, ...?ownerData};
    return data;
  }

  updateHomeStatus(String homeId, String status) async {
    final userData = await getCurrentUserData();
    final userHome =
        docUser.doc(userData['id']).collection('user_homes').doc(homeId);
    final homeUser =
        docHome.doc(homeId).collection('home_members').doc(userData['id']);
    if (status == 'accepted') {
      userHome.update({'home_status': 'accepted'});
      homeUser.update({'member_status': 'accepted'});
    } else {
      userHome.delete();
      homeUser.delete();
    }
  }

  validateUserOwner(String ownerId) async {
    final userData = await getCurrentUserData();
    final isOwner = userData['id'] == ownerId ? true : false;
    return isOwner;
  }
}
