import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/community/domain/entities/Comment.dart';
import 'package:samla_app/features/community/domain/entities/Post.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getAllPosts(int communityID);

  Future<Either<Failure, Post>> createPost(Post post);

  Future<Either<Failure, Unit>> deletePost(int postID);

  Future<Either<Failure, Post>> updatePost(int postID);

  // comment a post
  Future<Either<Failure, Comment>> commentPost(Comment comment);
  // like a post
  Future<Either<Failure, Unit>> likePost(int postID);
  // unlike a post
  Future<Either<Failure, Unit>> unlikePost(int postID);
  // get post comments
}
