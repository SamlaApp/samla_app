import 'package:samla_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.name, required super.email, required super.username, required super.phone, required super.dateOfBirth, required super.id, required super.accessToken});

// coming from server
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      phone: json['phone'],
      dateOfBirth: json['date_of_birth'],
      accessToken: json['access_token'],
    );
  }

// to json for sending to store it in local storage
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
