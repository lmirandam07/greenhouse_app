class UserModel {
  String id;
  final String? name;
  final String? username;
  final String? password;
  final String? email;

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
}
