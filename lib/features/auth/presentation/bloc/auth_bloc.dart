import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/core/auth/User.dart';
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
      if (event is ClearAuthEvent){
        emit(AuthInitial());
      }

      // login with email
      if (event is LoginWithEmailEvent) {
        emit(LoadingAuthState());
        final failuredOrDone =
            await loginWithEmail.call(event.email, event.password);
        await failuredOrDone.fold((failure) {
          emit(ErrorAuthState(message: failure.message));
        }, (returnedUser) async {
          user = returnedUser;
          await LocalAuth.init()
              .whenComplete(() => emit(AuthenticatedState(user: returnedUser)));
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
          await LocalAuth.init()
              .whenComplete(() => emit(AuthenticatedState(user: returnedUser)));
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

        await failuredOrDone.fold((failure) {
          emit(ErrorAuthState(message: failure.message));
        }, (returnedUser) async {
          user = returnedUser;
          await LocalAuth.init()
              .whenComplete(() => emit(AuthenticatedState(user: returnedUser)));
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
        await LocalAuth.init();

        await failuredOrDone.fold((failure) {
          emit(ErrorAuthState(message: failure.message));
        }, (returnedUser) async {
          user = returnedUser;
          await LocalAuth.init()
              .whenComplete(() => emit(AuthenticatedState(user: returnedUser)));
        });
      }
    });
  }
}
