import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:green_house/models/home_members.dart';

import '../../constants/app_colors.dart';
import '../../models/emission_model.dart';
import '../../models/user_model.dart';
import '../../models/home_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class FirestoreService {
  //Firebase methods for the user model
  FirestoreService();

  final docUser = FirebaseFirestore.instance.collection('user');
  final docHome = FirebaseFirestore.instance.collection('home');
  final docEmission = FirebaseFirestore.instance.collection('emission');

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }

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

  Future<bool> validateUserExistByEmail(String? email) async {
    final result = await docUser.where('email', isEqualTo: email).get();
    if (result.size > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> validateUserHomeExist(String homeId, String username) async {
    final user = await getUserData(username);
    final result = await docHome
        .doc(homeId)
        .collection('home_members')
        .where('member_id', isEqualTo: user['id'])
        .get();
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

  Future<QuerySnapshot<Map<String, dynamic>>> getUserHomesAccepted() async {
    final userData = await getCurrentUserData();
    final userHome = await docUser
        .doc(userData['id'])
        .collection('user_homes')
        .where('home_status', isEqualTo: 'accepted')
        .get();
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

  Future<List> getUserHomesAcceptedId() async {
    List userHomesId = [];
    final userHome = await getUserHomesAccepted();
    userHome.docs.forEach((homes) {
      userHomesId.add(homes.data()['home_id']);
    });
    return userHomesId;
  }

  Future<Iterable> getUserHomeList() async {
    final userHomesId = await getUserHomesId();
    final userHomeList = await docHome
        .where('home_id', whereIn: userHomesId)
        .where('activated', isEqualTo: true)
        .get();
    final userHomeDocs = userHomeList.docs
        .map((doc) => json.decode(json.encode(doc.data())))
        .toList();
    return userHomeDocs;
  }

  Future<Iterable> getUserHomeAcceptedList() async {
    final userHomesId = await getUserHomesAcceptedId();
    print(userHomesId);
    final userHomeList = await docHome
        .where('home_id', whereIn: userHomesId)
        .where('activated', isEqualTo: true)
        .get();
    final userHomeDocs = userHomeList.docs
        .map((doc) => json.decode(json.encode(doc.data())))
        .toList();
    return userHomeDocs;
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

  exitHome(String homeId, String ownerId) async {
    final userData = await getCurrentUserData();
    final isOwner = await validateUserOwner(ownerId);
    final userHome =
        docUser.doc(userData['id']).collection('user_homes').doc(homeId);

    userHome.delete();

    if (isOwner) {
      final home = docHome.doc(homeId);

      home.update({'activated': false});
    } else {
      final homeUser =
          docHome.doc(homeId).collection('home_members').doc(userData['id']);
      homeUser.delete();
    }
  }

  removeUser(String homeId, String username) async {
    final userData = await getUserData(username);
    final userHome =
        docUser.doc(userData['id']).collection('user_homes').doc(homeId);
    final homeUser =
        docHome.doc(homeId).collection('home_members').doc(userData['id']);

    userHome.delete();
    homeUser.delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getHomeUsers(
      String homeId) async {
    final homeUsers =
        await docHome.doc(homeId).collection('home_members').get();
    return homeUsers;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getHomeUsersAccepted(
      String homeId) async {
    final homeUsers = await docHome
        .doc(homeId)
        .collection('home_members')
        .where('member_status', isEqualTo: 'accepted')
        .get();
    return homeUsers;
  }

  Future<List> getHomeUsersId(String homeId) async {
    List homesUsersId = [];
    final homeUsers = await getHomeUsers(homeId);
    homeUsers.docs.forEach((homes) {
      homesUsersId.add(homes.data()['member_id']);
    });
    return homesUsersId;
  }

  Future<List> getHomeUsersIdAccepted(String homeId) async {
    List homesUsersId = [];
    final homeUsers = await getHomeUsersAccepted(homeId);
    homeUsers.docs.forEach((homes) {
      homesUsersId.add(homes.data()['member_id']);
    });
    return homesUsersId;
  }

  Future<Iterable> getHomeUserList(String homeId) async {
    final homeUsersId = await getHomeUsersId(homeId);
    final homeUsersList = await docUser.where('id', whereIn: homeUsersId).get();
    final homeUserDocs = homeUsersList.docs
        .map((doc) => json.decode(json.encode(doc.data())))
        .toList();
    return homeUserDocs;
  }

  Future<Iterable> getHomeUserAcceptedList(String homeId) async {
    final homeUsersId = await getHomeUsersIdAccepted(homeId);
    final homeUsersList = await docUser.where('id', whereIn: homeUsersId).get();
    final homeUserDocs = homeUsersList.docs
        .map((doc) => json.decode(json.encode(doc.data())))
        .toList();
    return homeUserDocs;
  }

  Future<bool> userHomeStatus(String homeId, String userId) async {
    final userHome =
        await docHome.doc(homeId).collection('home_members').doc(userId).get();
    return userHome['member_status'] == 'accepted' ? true : false;
  }

  Future<bool> currentUserHomeStatus(String homeId) async {
    final userData = await getCurrentUserData();
    final userHome = await docHome
        .doc(homeId)
        .collection('home_members')
        .doc(userData['id'])
        .get();
    return userHome['member_status'] == 'accepted' ? true : false;
  }

  createEmission(EmissionModel emission) async {
    emission.emission_id = docEmission.doc().id;
    await docEmission.doc(emission.emission_id).set(emission.toJson());
  }

  Future<Iterable> getHomeEmission(String? homeId) async {
    QuerySnapshot<Map<String, dynamic>> emissionsDocs = await docEmission
        .where('emission_home', isEqualTo: homeId)
        .orderBy('emission_register_date', descending: true)
        .get();
    List<Map<String, dynamic>> emissionsWithUsers = [];
    for (DocumentSnapshot<Map<String, dynamic>> emissionSnapshot
        in emissionsDocs.docs) {
      final emissionData = emissionSnapshot.data();
      final userSnapshot =
          await docUser.doc(emissionData?['emission_user']).get();

      final userData = userSnapshot.data();
      Map<String, dynamic> result = {...?emissionData, ...?userData};
      emissionsWithUsers.add(result);
    }
    return emissionsWithUsers;
  }

  Future<Iterable> getCurrentUserEmission() async {
    final userData = await getCurrentUserData();
    QuerySnapshot<Map<String, dynamic>> emissionsDocs = await docEmission
        .where('emission_user', isEqualTo: userData['id'])
        .get();

    List<Map<String, dynamic>> emissionsWithHome = [];
    var c = 0;
    for (DocumentSnapshot<Map<String, dynamic>> emissionSnapshot
        in emissionsDocs.docs) {
      final emissionData = emissionSnapshot.data();
      final homeSnapshot =
          await docHome.doc(emissionData?['emission_home']).get();

      final homeData = homeSnapshot.data();
      Map<String, dynamic> result = {...?emissionData, ...?homeData};
      emissionsWithHome.add(result);
    }
    return emissionsWithHome;
  }

  Future<Iterable> getUserEmission(String userId) async {
    final emissionsDocs =
        await docEmission.where('emission_user', isEqualTo: userId).get();
    final userEmissionList = emissionsDocs.docs
        .map((doc) => json.decode(json.encode(doc.data())))
        .toList();
    return userEmissionList;
  }

  Future<Iterable> getHomeUserEmission(String homeId, String userId) async {
    final emissionsDocs = await docEmission
        .where('emission_user', isEqualTo: userId)
        .where('emission_home', isEqualTo: homeId)
        .get();
    final homeUserEmissionList = emissionsDocs.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      data.forEach((key, value) {
        if (value is Timestamp) {
          data[key] = value.toDate();
        }
      });
      return data;
    }).toList();
    return homeUserEmissionList;
  }

  Future<double> homeEmissionTotal(String? homeId) async {
    double total = 0.0;
    final homeEmissionList = await getHomeEmission(homeId);
    homeEmissionList.forEach((emission) {
      total = total + emission['emission_value'];
    });
    return total;
  }

  Future<Map<String, double>> homeEmissionTotalByType(String? homeId) async {
    Map<String, double> totalByType;
    double totalPower = 0.0;
    double totalTransport = 0.0;
    double totalGas = 0.0;
    double totalTrash = 0.0;

    final homeEmissionList = await getHomeEmission(homeId);
    homeEmissionList.forEach((emission) {
      if (emission['emission_type'] == 'power') {
        totalPower = totalPower + emission['emission_value'];
      } else if (emission['emission_type'] == 'transport') {
        totalTransport = totalTransport + emission['emission_value'];
      } else if (emission['emission_type'] == 'gas') {
        totalGas = totalGas + emission['emission_value'];
      } else if (emission['emission_type'] == 'trash') {
        totalTrash = totalTrash + emission['emission_value'];
      }
    });
    totalByType = {
      'transporte': totalTransport,
      'energia': totalPower,
      'gas': totalGas,
      'basura': totalTrash
    };
    return totalByType;
  }

  Future<Map<double, double>> currentUserEmissionTotal() async {
    Map<double, double> totalByType;
    double totalPower = 0.0;
    double totalTransport = 0.0;
    double totalGas = 0.0;
    double totalTrash = 0.0;
    final userEmissionList = await getCurrentUserEmission();
    userEmissionList.forEach((emission) {
      if (emission['emission_type'] == 'power') {
        totalPower = totalPower + emission['emission_value'];
      } else if (emission['emission_type'] == 'transport') {
        totalTransport = totalTransport + emission['emission_value'];
      } else if (emission['emission_type'] == 'gas') {
        totalGas = totalGas + emission['emission_value'];
      } else if (emission['emission_type'] == 'trash') {
        totalTrash = totalTrash + emission['emission_value'];
      }
    });
    totalByType = {
      1: totalTransport,
      2: totalPower,
      3: totalGas,
      4: totalTrash
    };
    return totalByType;
  }

  Future<Map<double, double>> homeUserEmissionTotal(
      String homeId, String userId) async {
    Map<double, double> totalByType;
    double totalPower = 0.0;
    double totalTransport = 0.0;
    double totalGas = 0.0;
    double totalTrash = 0.0;
    final userEmissionList = await getHomeUserEmission(homeId, userId);
    userEmissionList.forEach((emission) {
      if (emission['emission_type'] == 'power') {
        totalPower = totalPower + emission['emission_value'];
      } else if (emission['emission_type'] == 'transport') {
        totalTransport = totalTransport + emission['emission_value'];
      } else if (emission['emission_type'] == 'gas') {
        totalGas = totalGas + emission['emission_value'];
      } else if (emission['emission_type'] == 'trash') {
        totalTrash = totalTrash + emission['emission_value'];
      }
    });
    totalByType = {
      1: totalTransport,
      2: totalPower,
      3: totalGas,
      4: totalTrash
    };
    return totalByType;
  }

  getHomeUserEmissionData(
      String homeId, Iterable homeUsers, List<Map> userEmission) async {
    for (var user in homeUsers) {
      Map<double, double> userEmissionValue =
          await homeUserEmissionTotal(homeId, user['id']);
      userEmission.add({
        'userName': user['username'],
        'email': user['email'],
        'profile': user['profile'],
        'powerValue': userEmissionValue[2],
        'transportValue': userEmissionValue[1],
        'gasValue': userEmissionValue[3],
        'trashValue': userEmissionValue[4],
        'totalEmision': userEmissionValue[2]! +
            userEmissionValue[1]! +
            userEmissionValue[3]! +
            userEmissionValue[4]!
      });
    }

    return userEmission;
  }

  Future<Iterable> getHomeUserEmissionList(String homeId) async {
    final homeUsers = await getHomeUserAcceptedList(homeId);
    List<Map> userEmission = [];
    final List<Map> userEmissionList =
        await getHomeUserEmissionData(homeId, homeUsers, userEmission);
    return userEmission;
  }

  getEmissionData(String emissionId) async {
    final emissionDoc = await docEmission.doc(emissionId).get();
    final emissionData = emissionDoc.data();

    if (emissionData != null &&
        emissionData.containsKey('emission_registered_date')) {
      final emissionDate = DateTime.fromMillisecondsSinceEpoch(
          emissionData['emission_registered_date'].millisecondsSinceEpoch);

      final formattedDate = DateFormat('dd/MM/yyyy').format(emissionDate);
      emissionData['emission_registered_date'] = formattedDate;
    }

    return emissionData;
  }

  updateEmission(Map<String, Object?> data, String emissionId) async {
    await docEmission.doc(emissionId).update(data);
  }

  deleteEmission(String emissionId) async {
    await docEmission.doc(emissionId).delete();
  }

  setNotification(bool activate) async {
    if (activate) {
      await FirebaseMessaging.instance.subscribeToTopic('notificaciones');
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic('notificaciones');
    }
  }
}
