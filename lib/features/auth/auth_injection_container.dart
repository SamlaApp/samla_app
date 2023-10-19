import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:samla_app/features/auth/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:samla_app/features/auth/domain/usecases/get_cached_user.dart';
import 'package:samla_app/features/auth/domain/usecases/logout.dart';
import 'package:samla_app/features/auth/domain/usecases/update_user_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/network_info.dart';
import 'data/datasources/local_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/login_email.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'domain/usecases/login_phone.dart';
import 'domain/usecases/login_username.dart';
import 'domain/usecases/send_OTP.dart';
import 'domain/usecases/signup.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

/*
this fucntion will initilize all the dependencies for the auth feature.
since most if you guys will not follow the clean architecure,
some of the objects may be dublecated throught the app.
*/
Future<void> AuthInit() async {
  //! Features - Auth

  // Bloc

  sl.registerLazySingleton(() => AuthBloc(
      loginWithEmail: sl(),
      loginWithPhone: sl(),
      checkOTP: sl(),
      signUp: sl(),
      loginWithUsername: sl(),
      getCachedUser: sl(),
      logout: sl(),
      update: sl()));

  // Use cases
  sl.registerLazySingleton(() => LoginWithEmail(repository: sl()));
  sl.registerLazySingleton(() => LoginWithUsername(repository: sl()));
  sl.registerLazySingleton(() => LoginWithPhoneNumber(repository: sl()));
  sl.registerLazySingleton(() => CheckOTP(repository: sl()));
  sl.registerLazySingleton(() => Signup(repository: sl()));
  sl.registerLazySingleton(() => GetCachedUser(repository: sl()));
  sl.registerLazySingleton(() => LogOutUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateUsecase(repository: sl()));

  // Repository

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));

  // Data sources

  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

User getUser() {
  return sl.get<AuthBloc>().user;
}
