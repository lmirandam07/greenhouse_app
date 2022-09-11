import 'dart:ffi';
import 'dart:html';
import 'package:latlng/latlng.dart';

class HomeModel {
  String home_id;
  final String name;
  final String owner;
  final double latitude;
  final double longitude;
  final users;

  HomeModel(
      {this.home_id = '',
      required this.name,
      required this.owner,
      required this.latitude,
      required this.longitude,
      required this.users});

  Map<String, dynamic> toJson() => {
        'home_id': home_id,
        'name': name,
        'owner': owner,
        'latitude': latitude,
        'longitude': longitude,
        "users": users
      };
}
