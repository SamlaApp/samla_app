import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _User {
  int id;
  String name;
  String email;
  String username;
  String phone;
  String dateOfBirth;
  String accessToken;

  _User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.dateOfBirth,
    required this.accessToken,
  });

  factory _User.fromJson(Map<String, dynamic> json) {
    return _User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      phone: json['phone'] as String,
      dateOfBirth: json['date_of_birth'] as String,
      accessToken: json['access_token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'phone': phone,
      'date_of_birth': dateOfBirth,
      'access_token': accessToken,
    };
  }
}

// class LocalAuth extends ChangeNotifier {
//   _User _user; // User cache
//   bool _isAuth = false;

//   _User get user => _user;
//   bool get isAuth => _isAuth;

//   LocalAuth(this._user, this._isAuth);

//   // Method to get the user
//   static Future<LocalAuth> init() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userData = prefs.getString('user');
//     if (userData != null) {
//       final jsonUser = json.decode(userData);
//       final user = _User.fromJson(jsonUser);
//       return LocalAuth(user, true);
//     } else {
//       throw EmptyCacheException();
//     }
//   }

//   // Update the user data and notify listeners
//   Future<void> updateUser({
//     String? username,
//     String? name,
//     String? dateOfBirth,
//     String? phone,
//   }) async {
//     // Update the user cache
//     if (_user != null) {
//       if (username != null) {
//         _user.username = username;
//       }
//       if (name != null) {
//         _user.name = name;
//       }
//       if (dateOfBirth != null) {
//         _user.dateOfBirth = dateOfBirth;
//       }
//       if (phone != null) {
//         _user.phone = phone;
//       }
//       // Update user data in SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('user', json.encode(_user.toJson()));
//       notifyListeners(); // Notify listeners about the change
//     }
//   }

//   // Reset the user cache and notify listeners
//   Future<void> resetCacheUser() async {
//     // Remove user data from SharedPreferences
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('user');
//     _isAuth = false;
//     notifyListeners(); // Notify listeners about the change
//   }
// }


abstract class LocalAuth {
  static late _User _user; // Static user cache
  static bool _isAuth = false;
  static _User get user => _user;

  // Method to get the user
  static Future<_User?> init() async {
    // Check if the user is cached
    if (_isAuth) {
      print('cached user found');
      return _user;
    }

    // Retrieve user data from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');

    if (userData != null) {
      // User data exists in SharedPreferences, parse it
      final jsonUser = json.decode(userData);
      _user = _User.fromJson(jsonUser);
      print('cached user created');
      _isAuth = true;
      return _user;
    }
    // user cannot be null, so you should handle this error by redirect the user to login page
    throw EmptyCacheException();
  }

// this only should be called after updating the remote user (in backend)!
  static Future<void> updateUser({
    String? username,
    String? name,
    String? dateOfBirth,
    String? phone,
  }) async{
    // Update the user cache
    if (username != null) {
      _user.username = username;
    }
    if (name != null) {
      _user.name = name;
    }
    if (dateOfBirth != null) {
      _user.dateOfBirth = dateOfBirth;
    }
    if (phone != null) {
      _user.phone = phone;
    }

    // Update user data in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(_user.toJson()));
  }

  // method to reset the user
  // this should be called after logout!
  static Future<void> resetCacheUser() async {
    // Reset the user cache
    print('hello world');
    // Remove user data from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    _isAuth = false;
    print('cached user reset');
  }
}
