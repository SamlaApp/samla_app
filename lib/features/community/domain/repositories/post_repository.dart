import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/community/domain/entities/Post.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getAllPosts(int communityID);

  Future<Either<Failure, Post>> createPost(Post post);

  Future<Either<Failure, Unit>> deletePost(int postID);

  Future<Either<Failure, Post>> updatePost(int postID);

  // comment a post
  Future<Either<Failure, Unit>> commentPost(int postID);
  // like a post
  Future<Either<Failure, Unit>> likePost(int postID);
  // unlike a post
  Future<Either<Failure, Unit>> unlikePost(int postID);
  // get number of comments
  Future<Either<Failure, int>> getPostComments(int postID);
}
