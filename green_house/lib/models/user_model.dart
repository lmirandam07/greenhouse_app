class UserModel {
  String id;
  final String? name;
  final String? username;
  final String? password;
  final String? email;
  final String profile =
      'https://firebasestorage.googleapis.com/v0/b/green-house-app-4828a.appspot.com/o/default%2Fdefault.png?alt=media&token=6589ce94-d767-4fd5-b728-cf1d55fa77d7';

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
        'email': email,
        'profile': profile
      };
}
