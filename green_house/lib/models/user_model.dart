import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final docUser = FirebaseFirestore.instance.collection('user').doc();
  String id;
  final String name;
  final String username;
  final String password;
  final String email;

  UserModel(
      {this.id = '',
      required this.name,
      required this.username,
      required this.email,
      required this.password});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'password': password,
        'email': email
      };

  createUser(UserModel user) async {
    user.id = docUser.id;
    await docUser.set(user.toJson());

  }
}
