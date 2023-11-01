import 'package:get_it/get_it.dart';
import 'package:samla_app/features/community/data/datasources/local_datasource.dart';
import 'package:samla_app/features/community/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/community/data/repositories/community_repo_impl.dart';
import 'package:samla_app/features/community/domain/repositories/community_repository.dart';
import 'package:samla_app/features/community/presentation/cubits/ExploreCubit/explore_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/MyCommunitiesCubit/community_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/SpecificCommunityCubit/specific_community_cubit.dart';

final sl = GetIt.instance;
bool _isInitialized = false;

void CommunityInit() {
  if (_isInitialized) {
    // Registration has already occurred, so do nothing.
    return;
  }
  // Features - Community
  /*  note that some of the following are factories, not singletons.
      this will allow us to create new instances of the cubits
      which is more efficient in term of memory usage since they 
      will be disposed when the screen is closed. and the garbage 
      collector will take care of them.
   */

  print('registering community dependencies');

  sl.registerLazySingleton(() => CommunityCubit(sl()));
  sl.registerLazySingleton(() => ExploreCubit(sl()));
  sl.registerFactory(() => SpecificCommunityCubit(sl()));
  sl.registerLazySingleton<CommunityRepository>(() => CommunityRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<CommunityRemoteDataSource>(
      () => CommunityRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CommunityLocalDataSource>(
      () => CommunityLocalDataSourceImpl(sl()));
  _isInitialized = true;
}
