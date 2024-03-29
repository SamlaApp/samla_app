part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// called to clear error state
class ClearAuthEvent extends AuthEvent {}

class LogOutEvent extends AuthEvent {
  final BuildContext context;

  LogOutEvent(this.context);
  
}

class UpdateUserEvent extends AuthEvent {
  final User user;
  UpdateUserEvent(this.user);

  @override
  List<Object> get props => [user];
}

class UpdateUserImageEvent extends AuthEvent {
  final File image;

  UpdateUserImageEvent(this.image);

  @override
  List<Object> get props => [image];
}

class LoginWithEmailEvent extends AuthEvent {
  final String email;
  final String password;

  LoginWithEmailEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginWithUsernameEvent extends AuthEvent {
  final String username;
  final String password;

  LoginWithUsernameEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class LoginWithPhoneEvent extends AuthEvent {
  final String phone;

  LoginWithPhoneEvent({required this.phone});

  @override
  List<Object> get props => [phone];
}

class CheckOTPEvent extends AuthEvent {
  final String otp;
  final String phone;

  CheckOTPEvent({required this.phone, required this.otp});

  @override
  List<Object> get props => [otp, phone];
}

class ResendOTPEvent extends AuthEvent {
  final String phone;

  ResendOTPEvent({required this.phone});

  @override
  List<Object> get props => [phone];
}

class CheckCachedUserEvent extends AuthEvent {
  final Function(bool) callBackFunction;

  const CheckCachedUserEvent({required this.callBackFunction});
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String username;
  final String phone;
  final String dateOfBirth;

  const SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.username,
    required this.phone,
    required this.dateOfBirth,
  });

  @override
  List<Object> get props => [email, password, username, phone, dateOfBirth];
}
