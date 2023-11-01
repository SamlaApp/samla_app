import 'package:samla_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.name,
      required super.email,
      required super.username,
      required super.phone,
      required super.dateOfBirth,
      required super.id,
      required super.accessToken});

// coming from server
  factory UserModel.fromJson(Map<String, dynamic> json) {
    print(json);

    return UserModel(
      id: json['id'].toString(),
      name: json['name'],
      email: json['email'],
      username: json['username'],
      phone: json['phone'],
      dateOfBirth: json['date_of_birth'],
      accessToken: json['access_token'],
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id ?? '',
      name: user.name,
      email: user.email,
      username: user.username,
      phone: user.phone,
      dateOfBirth: user.dateOfBirth,
      accessToken: user.accessToken ?? '',
    );
  }

// to json for sending to store it in local storage
  Map<String, String> toJson() {
    return {
      'id': id.toString(),
      'name': name,
      'email': email,
      'username': username,
      'phone': phone,
      'date_of_birth': dateOfBirth,
      'access_token': accessToken!,
    };
  }
}
