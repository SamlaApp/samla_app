import 'package:get_it/get_it.dart';
import 'package:samla_app/features/training/data/datasources/local_data_source.dart';
import 'package:samla_app/features/training/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/training/data/repositories/template_repository_impl.dart';
import 'package:samla_app/features/training/domain/repositories/template_repository.dart';
import 'package:samla_app/features/training/presentation/cubit/Templates/template_cubit.dart';



final sl = GetIt.instance;
bool _isInitialized = false;

void TrainingInit() {
  if (_isInitialized) {
    // Registration has already occurred, so do nothing.
    return;
  }


  print('registering training dependencies');
  sl.registerLazySingleton(() => TemplateCubit(sl()));
  sl.registerLazySingleton<TemplateRepository>(() => TemplateRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<RemoteDataSource>(
      () => TemplateRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sl()));
  _isInitialized = true;


}