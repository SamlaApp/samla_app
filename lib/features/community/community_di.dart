import 'package:get_it/get_it.dart';
import 'package:samla_app/features/community/data/datasources/community_admin_remote_data_source.dart';
import 'package:samla_app/features/community/data/datasources/community_local_datasource.dart';
import 'package:samla_app/features/community/data/datasources/community_remote_data_source.dart';
import 'package:samla_app/features/community/data/datasources/post_local_data_source.dart';
import 'package:samla_app/features/community/data/datasources/post_remote_data_source.dart';
import 'package:samla_app/features/community/data/repositories/community_admin_repo_impl.dart';
import 'package:samla_app/features/community/data/repositories/community_repo_impl.dart';
import 'package:samla_app/features/community/data/repositories/post_repo_impl.dart';
import 'package:samla_app/features/community/domain/repositories/community_admin_repository.dart';
import 'package:samla_app/features/community/domain/repositories/community_repository.dart';
import 'package:samla_app/features/community/domain/repositories/post_repository.dart';
import 'package:samla_app/features/community/presentation/cubits/AddComment/add_comment_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/CRUDPostCubit/crud_post_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/ExploreCubit/explore_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/GetPosts/get_posts_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/ManageMemebers/get_memebers_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/MyCommunitiesCubit/community_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/PostCubit/post_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/RequestsManager/requests_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/Search/search_cubit.dart';
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

//cubits
  sl.registerLazySingleton(() => CommunityCubit(sl()));
  sl.registerLazySingleton(() => ExploreCubit(sl()));
  sl.registerFactory(() => SpecificCommunityCubit(sl()));
  sl.registerFactory(() => PostCubit(sl()));
  sl.registerFactory(() => GetPostsCubit(sl()));
  sl.registerFactoryParam((int community, _) => CrudPostCubit(community, sl()));
  sl.registerFactory(() => AddCommentCubit(sl()));
  sl.registerFactory(() => MemebersCubit(sl(), sl()));
  sl.registerFactory(() => RequestsCubit(sl()));
  sl.registerFactory(() => SearchCubit(sl()));
  //datasources
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl());
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<CommunityRemoteDataSource>(
      () => CommunityRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CommunityLocalDataSource>(
      () => CommunityLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<CommunityAdminRemoteDataSource>(
      () => CommunityAdminRemoteDataSourceImpl());

  //repositories
  sl.registerLazySingleton<CommunityRepository>(() => CommunityRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
      networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<CommunityAdminRepository>(
      () => CommunityAdminRepositoryImpl(remoteDataSource: sl()));
  _isInitialized = true;
}
