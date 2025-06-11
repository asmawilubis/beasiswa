class UserModel {
  int id;
  String name;
  String email;
  String username;
  String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      email = json['email'],
      username = json['username'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'token': token,
    };
  }
}
