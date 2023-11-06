import 'package:get_it/get_it.dart';
import 'package:samla_app/features/main/presentation/cubits/ProgressCubit/progress_cubit.dart';
import 'package:samla_app/features/main/data/datasources/local_data_source.dart';
import 'package:samla_app/features/main/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/main/domain/repositories/progress_repository.dart';

import 'data/repositories/progress_repository_impl.dart';



final sl = GetIt.instance;
bool _isInitialized = false;

void HomeInit() {
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
  sl.registerLazySingleton(() => ProgressCubit(sl()));
  sl.registerLazySingleton<ProgressRepository>(() => ProgressRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<ProgressRemoteDataSource>(
      () => ProgressRemoteDataSourceImpl());
  sl.registerLazySingleton<ProgressLocalDataSource>(
      () => ProgressLocalDataSourceImpl(sl()));

  _isInitialized = true;
}