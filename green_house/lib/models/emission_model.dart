class EmissionModel {
  String emission_id;
  final String emission_title;
  final String emission_type;
  final double emission_value;
  final DateTime emission_register_date = DateTime.now();
  final String emission_userId;
  final String emission_homeId;

  EmissionModel(
      {this.emission_id = '',
      required this.emission_title,
      required this.emission_type,
      required this.emission_value,
      required this.emission_userId,
      required this.emission_homeId});

  Map<String, dynamic> toJson() => {
        'emission_id': emission_id,
        'emission_title': emission_title,
        'emission_type': emission_type,
        'emission_value': emission_value,
        'emission_register_date': emission_register_date,
        'emission_user': emission_userId,
        'emission_home': emission_homeId
      };
}
