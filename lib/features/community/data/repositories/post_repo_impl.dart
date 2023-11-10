import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/core/network/network_info.dart';
import 'package:samla_app/features/community/data/datasources/post_local_data_source.dart';
import 'package:samla_app/features/community/data/datasources/post_remote_data_source.dart';
import 'package:samla_app/features/community/data/models/Post.dart';
import 'package:samla_app/features/community/domain/entities/Post.dart';
import 'package:samla_app/features/community/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, Post>> createPost(Post post)async {
    if (await networkInfo.isConnected) {
      try {
        final  newPost = await remoteDataSource.addPost(PostModel.fromEntity(post));
        return Right(newPost);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
      }
    
  }

  
  @override
  Future<Either<Failure, List<Post>>> getAllPosts(int communityID) async  {
    if  (await networkInfo.isConnected){
      try {
        final remotePosts = await remoteDataSource.getAllPosts(communityID);
        localDataSource.cachePosts(remotePosts, communityID);
        return Right(remotePosts);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts(communityID);
        return Right(localPosts);
      } on EmptyCacheException catch (e) {
        return Left(EmptyCacheFailure(message: e.message));
      }
    }
  }
  
  @override
  Future<Either<Failure, Unit>> commentPost(int postID) {
    // TODO: implement commentPost
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, Unit>> deletePost(int postID) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, int>> getPostComments(int postID) {
    // TODO: implement getPostComments
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, Unit>> likePost(int postID) {
    // TODO: implement likePost
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, Unit>> unlikePost(int postID) {
    // TODO: implement unlikePost
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, Post>> updatePost(int postID) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
  

  }

  