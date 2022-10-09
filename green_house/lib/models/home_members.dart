import 'package:cloud_firestore/cloud_firestore.dart';

class HomeMembersModel {
  final String member_id;
  final String member_role;
  final String member_status;

  HomeMembersModel(
      {required this.member_id,
      required this.member_role,
      required this.member_status});

  Map<String, dynamic> toJson() => {
        'member_id': member_id,
        'member_role': member_role,
        'member_status': member_status
      };
}
