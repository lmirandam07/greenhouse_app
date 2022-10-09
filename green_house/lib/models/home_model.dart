import 'package:cloud_firestore/cloud_firestore.dart';

class HomeModel {
  String home_id;
  final String home_name;
  final String owner_id;
  final GeoPoint ubication;

  HomeModel(
      {this.home_id = '',
      required this.home_name,
      required this.owner_id,
      required this.ubication});

  Map<String, dynamic> toJson() => {
        'home_id': home_id,
        'home_name': home_name,
        'owner_id': owner_id,
        'ubication': ubication
      };
}
