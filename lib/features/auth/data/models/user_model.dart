import 'package:samla_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.name,
      required super.email,
      required super.username,
      required super.phone,
      required super.dateOfBirth,
      required super.id,
      required super.accessToken,
      super.photoUrl,
      super.gender,
      super.height,
      super.hasGoal
      });

// coming from server
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      gender: json['gender'],
      height: json['height'],
      hasGoal: json['has_goal'],
      photoUrl: json['photo'],
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
      gender: user.gender ?? '',
      height: user.height ?? 0,
      hasGoal: user.hasGoal ?? false,
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
      'photo':photoUrl ?? '',
      'height': height.toString(),
      'has_goal': hasGoal.toString()
    };
  }
}
