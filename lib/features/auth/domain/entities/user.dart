import 'dart:io';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  String? id;
  String name;
  String email;
  String username;
  String phone;
  String dateOfBirth;
  String? accessToken;
  String? photoUrl;
  String? gender;
  double? height;
  double? weight;
  bool hasGoal;
  File? image;

  User({
    this.image,
    this.gender,
    this.height,
    this.hasGoal = false,
    this.photoUrl,
    this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.dateOfBirth,
    this.accessToken,
  });

  // copywith function

  User copyWith({
    File? image,
    String? gender,
    double? height,
    bool? hasGoal,
    String? photoUrl,
    String? id,
    String? name,
    String? email,
    String? username,
    String? phone,
    String? dateOfBirth,
    String? accessToken,
  }) {
    return User(
      image: image ?? this.image,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      hasGoal: hasGoal ?? this.hasGoal,
      photoUrl: photoUrl ?? this.photoUrl,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, email, username, phone, dateOfBirth, accessToken, image];
}
