import 'package:get_it/get_it.dart';
import 'package:samla_app/features/notifications/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:samla_app/features/notifications/domain/repositories/notification_repository.dart';
import 'package:samla_app/features/notifications/domain/usecases/get_cached_notification.dart';
import 'package:samla_app/features/notifications/domain/usecases/get_notifications.dart';
import 'package:samla_app/features/notifications/presentation/bloc/notification_bloc.dart';
import 'data/datasources/local_data_source.dart';


final sl = GetIt.instance;

/*
this fucntion will initilize all the dependencies for the auth feature.
since most if you guys will not follow the clean architecure,
some of the objects may be dublecated throught the app.
*/
Future<void> NotificationInit() async {
  //! Features - Auth

  // Bloc

  sl.registerLazySingleton(() => NotificationBloc(
        getCachedNotification: sl(),
        getNotifications: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetNotifications(sl()));
  sl.registerLazySingleton(() => GetCachedNotification(sl()));

  // Repository

  sl.registerLazySingleton<NotificationRepository>(() =>
      NotificationRepositoryImpl(
          networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));

  // Data sources

  sl.registerLazySingleton<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NotificationLocalDataSource>(
      () => NotificationLocalDataSourceImpl(sharedPreferences: sl()));

  // //! Core
  // sl.registerLazySingleton<NetworkInfo>(
  //     () => NetworkInfoImpl(connectionChecker: sl()));

  //! External
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
  // sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => InternetConnectionChecker());
}
