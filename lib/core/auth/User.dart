import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String username;
  final String phone;
  final String dateOfBirth;
  final String accessToken;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.dateOfBirth,
    required this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      phone: json['phone'] as String,
      dateOfBirth: json['date_of_birth'] as String,
      accessToken: json['access_token'] as String,
    );
  }
}

User? user;

class Auth {
  static User? _cachedUser; // Static user cache

  // Method to get the user
  static Future<User?> getUser() async {
    // Check if the user is cached
    if (_cachedUser != null) {
      print('cached user found');
      user = _cachedUser;
      return _cachedUser;
    }

    // Retrieve user data from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');

    if (userData != null) {
      // User data exists in SharedPreferences, parse it
      final jsonUser = json.decode(userData);
      _cachedUser = User.fromJson(jsonUser);
      print('cached user created');
      user = _cachedUser;
      return _cachedUser;
    }

    // If no user data in SharedPreferences, return a static user or null
    return _cachedUser; // You can return null or a static user here
  }

  // method to reset the user
  static Future<void> resetUser() async {
    // Reset the user cache
    _cachedUser = null;
    user = null;
    // Remove user data from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    print('cached user reset');
  }
}
