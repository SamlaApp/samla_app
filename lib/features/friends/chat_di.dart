import 'package:get_it/get_it.dart';
import 'package:samla_app/features/friends/presentation/cubit/FetchStreak/fetch_streak_cubit.dart';
import 'package:samla_app/features/friends/presentation/cubit/explore/explore_cubit.dart';
import 'package:samla_app/features/friends/presentation/cubit/friendShip/friend_ship_cubit.dart';
import 'package:samla_app/features/friends/presentation/cubit/friends/friends_cubit.dart';
import 'package:samla_app/features/friends/presentation/cubit/messages/messages_cubit.dart';
import 'data/datasources/localDataSource.dart';
import 'data/datasources/remoteDataSource.dart';
import 'data/repositories/explore_repo_impl.dart';
import 'data/repositories/friend_repo_impl.dart';
import 'data/repositories/messages_repo_impl.dart';
import 'domain/repositories/explore_repo.dart';
import 'domain/repositories/friend_repo.dart';
import 'domain/repositories/messages_repo.dart';

final sl = GetIt.instance;

bool isChatInitialized = false;

Future<void> chatInit() async {
  if (isChatInitialized) {
    return; // If already initialized, exit early
  }

  print('ChatInit');

  sl.registerLazySingleton(() => ExploreCubit(sl()));
  sl.registerLazySingleton(() => FriendCubit(sl()));
  sl.registerFactory(() => MessagesCubit(sl()));
  sl.registerFactory(() => FriendShipCubit(sl()));
  sl.registerFactory(() => FetchStreakCubit(sl()));

  sl.registerLazySingleton<ExploreRepository>(() => ExploreRepositoryImpl(
      localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<MessageRepository>(() => MessageRepositoryImpl(
      localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<FriendRepository>(() => FriendRepositoryImpl(
      localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());

  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: sl()));

  print("ChatInit Done");
  isChatInitialized = true; // Set the flag to true after initialization
}
