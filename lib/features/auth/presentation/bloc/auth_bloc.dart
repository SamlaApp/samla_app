import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/auth/domain/usecases/login_email.dart';
import 'package:samla_app/features/auth/domain/usecases/login_phone.dart';
import 'package:samla_app/features/auth/domain/usecases/login_username.dart';
import 'package:samla_app/features/auth/domain/usecases/send_OTP.dart';
import 'package:samla_app/features/auth/domain/usecases/signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithEmail loginWithEmail;
  final LoginWithUsername loginWithUsername;
  final LoginWithPhoneNumber loginWithPhone;
  final CheckOTP checkOTP;
  final Signup signUp;
  User? user;

  AuthBloc(
      {required this.loginWithUsername,
      required this.loginWithPhone,
      required this.checkOTP,
      required this.signUp,
      required this.loginWithEmail})
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      // login with email
      if (event is LoginWithEmailEvent) {
        emit(LoadingAuthState());
        final failuredOrDone =
            await loginWithEmail(event.email, event.password);
        failuredOrDone.fold((failure) {
          emit(ErrorAuthState(message: failure.message));
        }, (returnedUser) {
          user = returnedUser;
          emit(AuthenticatedState(user: returnedUser));
        });
      }

      // login with username
      else if (event is LoginWithUsernameEvent) {
        emit(LoadingAuthState());
        final failuredOrDone =
            await loginWithUsername(event.username, event.password);
        failuredOrDone.fold((failure) {
          emit(ErrorAuthState(message: failure.message));
        }, (returnedUser) {
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
        final failuredOrDone = await checkOTP(event.phone, event.otp);
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
        final failuredOrDone = await loginWithPhone(event.phone);
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
        failuredOrDone.fold((failure) {
          emit(ErrorAuthState(message: failure.message));
        }, (returnedUser) {
          emit(AuthenticatedState(user: returnedUser));
        });
      }
    });
  }
}
