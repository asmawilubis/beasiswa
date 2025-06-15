import 'dart:convert';

import 'package:beasiswa/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  String baseUrl = 'http://192.168.1.15:8000/api'; // url API

  Future<UserModel> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    var url = Uri.parse('$baseUrl/register');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });

    var response = await http.post(url, headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ${data['access_token']}';

      return user;
    } else {
      throw Exception('Failed to register user: ${response.body}');
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse('$baseUrl/login');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'email': email, 'password': password});

    var response = await http.post(url, headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ${data['access_token']}';

      return user;
    } else {
      throw Exception('Failed to Login user: ${response.body}');
    }
  }

  Future<void> logout(String token) async {
    var url = Uri.parse('$baseUrl/logout');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var response = await http.post(url, headers: headers);

    if (response.statusCode != 200) {
      throw Exception('Failed to logout: ${response.body}');
    }
  }
}
