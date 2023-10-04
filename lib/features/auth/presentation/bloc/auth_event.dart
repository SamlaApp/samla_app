// part of 'auth_bloc.dart';

// abstract class AuthEvent extends Equatable {
//   const AuthEvent();

//   @override
//   List<Object> get props => [];
// }

// class LoginWithEmailEvent extends AuthEvent {
//   final String email;
//   final String password;

//   LoginWithEmailEvent({required this.email, required this.password});

//   @override
//   List<Object> get props => [email, password];
// }

// class LoginWithUsernameEvent extends AuthEvent {
//   final String username;
//   final String password;

//   LoginWithUsernameEvent({required this.username, required this.password});

//   @override
//   List<Object> get props => [username, password];
// }

// class LoginWithPhoneEvent extends AuthEvent {
//   final String phone;

//   LoginWithPhoneEvent({required this.phone});

//   @override
//   List<Object> get props => [phone];
// }

// class CheckOTPEvent extends AuthEvent {
//   final String otp;

//   CheckOTPEvent({required this.otp});

//   @override
//   List<Object> get props => [otp];
// }

// class ResendOTPEvent extends AuthEvent {
//   final String phone;

//   ResendOTPEvent({required this.phone});

//   @override
//   List<Object> get props => [phone];
// }

// class SignUpEvent extends AuthEvent {
//   final String email;
//   final String password;
//   final String username;
//   final String phone;
//   final String dateOfBirth;

//   SignUpEvent({
//     required this.email,
//     required this.password,
//     required this.username,
//     required this.phone,
//     required this.dateOfBirth,
//   });

//   @override
//   List<Object> get props => [email, password, username, phone, dateOfBirth];
// }
