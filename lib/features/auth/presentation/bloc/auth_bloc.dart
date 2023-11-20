import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/auth/domain/usecases/get_cached_user.dart';
import 'package:samla_app/features/auth/domain/usecases/login_email.dart';
import 'package:samla_app/features/auth/domain/usecases/login_phone.dart';
import 'package:samla_app/features/auth/domain/usecases/login_username.dart';
import 'package:samla_app/features/auth/domain/usecases/logout.dart';
import 'package:samla_app/features/auth/domain/usecases/send_OTP.dart';
import 'package:samla_app/features/auth/domain/usecases/signup.dart';
import 'package:samla_app/features/auth/domain/usecases/update_user_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithEmail loginWithEmail;
  final LoginWithUsername loginWithUsername;
  final LoginWithPhoneNumber loginWithPhone;
  final CheckOTP checkOTP;
  final Signup signUp;
  final GetCachedUser getCachedUser;
  final LogOutUsecase logout;
  final UpdateUsecase update;
  late User user;

  AuthBloc(
      {required this.logout,
      required this.update,
      required this.loginWithUsername,
      required this.loginWithPhone,
      required this.checkOTP,
      required this.signUp,
      required this.getCachedUser,
      required this.loginWithEmail})
      : super(UnauthenticatedState()) {
    //check cached user

    on<AuthEvent>((event, emit) async {
      if (event is ClearAuthEvent) {
        emit(UnauthenticatedState());
      }

      // update user
      else if (event is UpdateUserEvent) {
        emit(LoadingAuthState());
        final failuredOrDone = await update.call(event.user);

        failuredOrDone.fold((failure) {
          emit(ErrorAuthState(message: failure.message));
        }, (returnedUser) {
          emit(AuthenticatedState(user: returnedUser));
          _updateUser(returnedUser);
        });
      }

      // check whether there is a cached user
      else if (event is CheckCachedUserEvent) {
        emit(LoadingAuthState());
        final failuredOrDone = await getCachedUser.call();
        failuredOrDone.fold((failure) {
          emit(UnauthenticatedState());
          print(failure.message);
          event.callBackFunction(false);
        }, (returnedUser) {
          user = returnedUser;
          emit(AuthenticatedState(user: returnedUser));
          event.callBackFunction(true);
        });
      }

      // logout
      else if (event is LogOutEvent) {
        emit(LoadingAuthState());
        final failuredOrDone = await logout.call(token: user.accessToken!);
        failuredOrDone.fold((failure) {
          print('failded to logout ${failure.message}');
          emit(ErrorAuthState(message: failure.message));
        }, (_) {
          emit(UnauthenticatedState());
          Navigator.of(event.context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
        });
      }

      // login with email
      else if (event is LoginWithEmailEvent) {
        emit(LoadingAuthState());
        final failuredOrDone =
            await loginWithEmail.call(event.email, event.password);
        await failuredOrDone.fold((failure) {
          emit(ErrorAuthState(message: failure.message));
        }, (returnedUser) async {
          user = returnedUser;
          emit(AuthenticatedState(user: returnedUser));
        });
      }

      // login with username
      else if (event is LoginWithUsernameEvent) {
        emit(LoadingAuthState());
        final failuredOrDone =
            await loginWithUsername.call(event.username, event.password);

        await failuredOrDone.fold((failure) {
          emit(ErrorAuthState(message: failure.message));
        }, (returnedUser) async {
          user = returnedUser;
          emit(AuthenticatedState(user: returnedUser));
        });
      }

      // login with phone
      else if (event is LoginWithPhoneEvent) {
        emit(LoadingAuthState());
        final failuredOrDone = await loginWithPhone.call(event.phone);
        failuredOrDone.fold((failure) {
          emit(ErrorAuthState(message: failure.message));
        }, (_) {
          emit(OTPSentState(phone: event.phone));
        });
      }

      // check OTP
      else if (event is CheckOTPEvent) {
        emit(LoadingAuthState());
        final failuredOrDone = await checkOTP.call(event.phone, event.otp);

        failuredOrDone.fold((failure) {
          emit(ErrorAuthState(message: failure.message));
        }, (returnedUser) {
          user = returnedUser;
          emit(AuthenticatedState(user: returnedUser));
        });
      }

      // resend OTP
      else if (event is ResendOTPEvent) {
        emit(LoadingAuthState());
        final failuredOrDone = await loginWithPhone.call(event.phone);

        failuredOrDone.fold((failure) {
          emit(ErrorAuthState(message: failure.message));
        }, (_) {
          emit(OTPSentState(phone: event.phone));
        });
      }

      // sign up
      else if (event is SignUpEvent) {
        emit(LoadingAuthState());
        final failuredOrDone = await signUp.call(event.name, event.email,
            event.username, event.phone, event.dateOfBirth, event.password);

        await failuredOrDone.fold((failure) {
          emit(ErrorAuthState(message: failure.message));
        }, (returnedUser) async {
          user = returnedUser;
          emit(AuthenticatedState(user: returnedUser));
        });
      }
    });
  }
  // update user without change its reference
  void _updateUser(User newUser) {
    user.name = newUser.name;
    user.email = newUser.email;
    user.username = newUser.username;
    user.phone = newUser.phone;
    user.dateOfBirth = newUser.dateOfBirth;
    user.accessToken = newUser.accessToken;
    user.gender = newUser.gender;
    user.height = newUser.height;
    user.hasGoal = newUser.hasGoal;
    user.photoUrl = newUser.photoUrl;
  }
}
