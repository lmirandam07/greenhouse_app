class UserModel {
  String id;
  final String? name;
  final String? username;
  final String? password;
  final String? email;
  String profile;

  UserModel(
      {this.id = '',
      required this.name,
      required this.username,
      required this.email,
      required this.password,
      required this.profile});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'password': password,
        'email': email,
        'profile': profile
      };
}
