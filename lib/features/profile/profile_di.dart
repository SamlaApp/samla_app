import 'package:get_it/get_it.dart';
import 'package:samla_app/features/profile/data/goals_repository.dart';
import 'package:samla_app/features/profile/presentation/cubit/profile_cubit.dart';

final sl = GetIt.instance;
bool _isInitialized = false;

void ProfileInit() {
  if (_isInitialized) {
    // Registration has already occurred, so do nothing.
    return;
  }
  
//cubits
  sl.registerLazySingleton(() => ProfileCubit(sl()));
  
  //repositories
  sl.registerLazySingleton<GoalsRepository>(() => GoalsRepository(sl(), sl()));
  
}
