import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';

class UserService {
   //Firebase metods for the user model
  UserService();

  final docUser = FirebaseFirestore.instance.collection('user');

  createUser(UserModel user) async {
    user.id = docUser.doc().id;
    await docUser.doc().set(user.toJson()); 
  }

   Future<bool>validateUserExist(String username) async {
    final result = await docUser
        .where('username', isEqualTo: username)
        .get();
    if (result.size > 0 ){
      return true;
    }else{
      return false;
    }
    
  }
}
