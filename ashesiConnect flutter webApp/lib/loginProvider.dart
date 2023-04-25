import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'user_model.dart';

class User {
  final String id;
  final String password;
  User({required this.id, required this.password});
}

class LoginProvider extends ChangeNotifier {
  User? _currentUser;
  late UserModel _data;

  User? getCurrentUser() => _currentUser;
  UserModel getUserData() => _data;

  Future<bool> login(User user) async {
    // print(user.id + user.password);
    final response = await http.get(Uri.parse(ApiConstants.baseUrl + '/?id=' + user.id));

    if (response.statusCode == 200) {
      _data = userModelFromJson(response.body);
        if(user.password == _data.pass) {
          _currentUser = user;
          return true;
        }
        else{
          return false;
        }
    } else {
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  bool isLoggedIn() {
    return _currentUser != null;
  }
}
