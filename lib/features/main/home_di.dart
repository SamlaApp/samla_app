import 'package:get_it/get_it.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'package:samla_app/features/main/data/repositories/steps_repository.dart';
import 'package:samla_app/features/main/data/repositories/streak_repository_impl.dart';
import 'package:samla_app/features/main/domain/repositories/streak_repository.dart';
import 'package:samla_app/features/main/presentation/cubits/ProgressCubit/progress_cubit.dart';
import 'package:samla_app/features/main/data/datasources/local_data_source.dart';
import 'package:samla_app/features/main/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/main/domain/repositories/progress_repository.dart';
import 'package:samla_app/features/main/presentation/cubits/SensorCubit/steps_cubit.dart';
import 'package:samla_app/features/main/presentation/cubits/StepsLogCubit/steps_log_cubit.dart';
import 'package:samla_app/features/main/presentation/cubits/steps_timer_loop.dart';
import 'package:workmanager/workmanager.dart';
import 'package:samla_app/features/main/presentation/cubits/StreakCubit/streak_cubit.dart';

import 'data/repositories/progress_repository_impl.dart';

final sl = GetIt.instance;
bool _isInitialized = false;

Future<void> HomeInit() async {
  if (_isInitialized) {
    // Registration has already occurred, so do nothing.
    return;
  }
  // Features - Home
  /*  note that some of the following are factories, not singletons.
      this will allow us to create new instances of the cubits
      which is more efficient in term of memory usage since they
      will be disposed when the screen is closed. and the garbage
      collector will take care of them.
   */

  print('registering home dependencies');
  sl.registerLazySingleton(() => SensorCubit());
  sl.registerLazySingleton<StepsLogCubit>(() => StepsLogCubit(sl()));
  sl.registerLazySingleton(() => StepsRepository(sl()));
  sl.registerLazySingleton<ProgressCubit> (() => ProgressCubit(sl()));
  sl.registerLazySingleton<StreakCubit> (() => StreakCubit(sl()));

  sl.registerLazySingleton<StreakRepository>(() => StreakRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));

  sl.registerLazySingleton<ProgressRepository>(() => ProgressRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<RemoteDataSource>(
      () => ProgressRemoteDataSourceImpl());
  sl.registerLazySingleton<LocalDataSource>(
      () => ProgressLocalDataSourceImpl(sl()));

  await sl<SensorCubit>().init();
  await sl<StepsLogCubit>().init();
  await stepsBackground(sl<SensorCubit>());

  _isInitialized = true;
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await HomeInit();
    await AuthInit();
    switch (task) {
      case "stepsBackground":
        try {
          await stepsBackground(inputData!['cubit']);
        } catch (e) {
          print('error in stepsBackground');
          print(e.toString());
          return Future.value(false);
        }
        break;
    }
    return Future.value(true);
  });
}

Future<void> initWorkManager() async {
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await Workmanager().registerPeriodicTask(
    inputData: {'cubit': sl.get<SensorCubit>()},
    "stepsBackground",
    "stepsBackground",
    frequency: Duration(minutes: 15),
  );
}
