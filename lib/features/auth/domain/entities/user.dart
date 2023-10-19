import 'package:equatable/equatable.dart';

class User extends Equatable {
  String? id;
  String name;
  String email;
  String username;
  String phone;
  String dateOfBirth;
  String? accessToken;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.dateOfBirth,
    this.accessToken,
  });



  @override
  List<Object?> get props =>
      [id, name, email, username, phone, dateOfBirth, accessToken];
}
