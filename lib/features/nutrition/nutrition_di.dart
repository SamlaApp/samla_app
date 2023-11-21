import 'package:get_it/get_it.dart';
import 'package:samla_app/features/nutrition/data/datasources/local_datasource.dart';
import 'package:samla_app/features/nutrition/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/nutrition/data/repositories/nutritionPlan_repository_impl.dart';
import 'package:samla_app/features/nutrition/domain/repositories/nutritionPlan_repository.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/TodayPlan/todayPlan_cubit.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/nutrtiionPlan/nutritionPlan_cubit.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/summary/summary_cubit.dart';

final sl = GetIt.instance;
bool _isInitialized = false;

void nutritionInit() {
  if (_isInitialized) {
    // Registration has already occurred, so do nothing.

    return;
  }
  // }
  // Features - Nutrition
  /*  note that some of the following are factories, not singletons.
      this will allow us to create new instances of the cubits
      which is more efficient in term of memory usage since they
      will be disposed when the screen is closed. and the garbage
      collector will take care of them.
   */

  print('registering nutrition dependencies');

  sl.registerLazySingleton<NutritionPlanCubit>(() => NutritionPlanCubit(sl()));
  sl.registerLazySingleton<SummaryCubit>(() => SummaryCubit(sl()));
  sl.registerLazySingleton<TodayPlanCubit>(() => TodayPlanCubit(sl()));

  sl.registerLazySingleton<NutritionPlanRepository>(() =>
      NutritionPlanRepositoryImpl(
          networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<NutritionPlanRemoteDataSource>(
      () => NutritionPlanRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NutritionPlanLocalDataSource>(
      () => NutritionPlanLocalDataSourceImpl(sl()));

  _isInitialized = true;
}



