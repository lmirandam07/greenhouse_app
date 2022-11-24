class UserHomesModel {
  final String home_id;
  final String home_status;

  UserHomesModel({required this.home_id, required this.home_status});

  Map<String, dynamic> toJson() =>
      {'home_id': home_id, 'home_status': home_status};
}
