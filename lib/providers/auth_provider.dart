import 'package:beasiswa/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:beasiswa/services/auth_services.dart';

class AuthProvider extends ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = await AuthServices().register(
        name: name,
        username: username,
        email: email,
        password: password,
      );
      _user = user;
      return true;
    } catch (e) {
      print('Registration failed: $e');
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      UserModel user = await AuthServices().login(
        email: email,
        password: password,
      );
      _user = user;
      return true;
    } catch (e) {
      print('Registration failed: $e');
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      if (_user.token == null) {
        print('User token is null, cannot logout.');
        return false;
      }

      await AuthServices().logout(_user.token!);

      return true;
    } catch (e) {
      print('Logout failed: $e');
      return false;
    }
  }
}
