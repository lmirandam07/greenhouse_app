import 'dart:ffi';

class HomeModel {
  String home_id;
  final String home_name;
  final String owner_id;
  final bool activated;
  final Map<String, double?> ubication;

  HomeModel(
      {this.home_id = '',
      required this.home_name,
      required this.owner_id,
      required this.activated,
      required this.ubication});

  Map<String, dynamic> toJson() => {
        'home_id': home_id,
        'home_name': home_name,
        'owner_id': owner_id,
        'activated': activated,
        'ubication': ubication
      };
}
