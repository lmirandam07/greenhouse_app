class EmissionModel {
  final String emission_id;
  final String emission_title;
  final String emission_type;
  final double emission_value;
  final String emission_user;
  final String emission_home;

  EmissionModel(
      {this.emission_id = '',
      required this.emission_title,
      required this.emission_type,
      required this.emission_value,
      required this.emission_user,
      required this.emission_home});

  Map<String, dynamic> toJson() => {
        'emission_id': emission_id,
        'emission_title': emission_title,
        'emission_type': emission_type,
        'emission_value': emission_value,
        'emission_user': emission_user,
        'emission_home': emission_home
      };
}
