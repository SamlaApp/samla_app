part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class UnauthenticatedState extends AuthState {}

class LoadingAuthState extends AuthState {}



class OTPSentState extends AuthState {
  final String phone;

  OTPSentState({required this.phone});

  @override
  List<Object> get props => [phone];
}

class AuthenticatedState extends AuthState {
  final User user;

  AuthenticatedState({required this.user});

  @override
  List<Object> get props => [user];
}

class ErrorAuthState extends AuthState {
  final String message;

  ErrorAuthState({required this.message});

  @override
  List<Object> get props => [message];
}
