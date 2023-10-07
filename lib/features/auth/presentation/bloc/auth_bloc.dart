// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:samla_app/core/auth/User.dart';
// import 'package:samla_app/features/auth/domain/usecases/login_email.dart';

// part 'auth_event.dart';
// part 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final LoginWithEmail loginWithEmail;

//   AuthBloc({required this.loginWithEmail}) : super(AuthInitial()) {
//     on<AuthEvent>((event, emit) async {
//       if (event is LoginWithEmailEvent) {
//         emit(LoadingAuthState());
//         final res = await loginWithEmail();
//       } else if (event is LoginWithUsernameEvent) {}
//     });
//   }
// }
