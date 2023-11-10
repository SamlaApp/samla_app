part of 'get_posts_cubit.dart';

sealed class GetPostsState extends Equatable {
  const GetPostsState();

  @override
  List<Object> get props => [];
}

final class GetPostsInitial extends GetPostsState {}

final class GetPostsLoaded extends GetPostsState {
  final List<Post> posts;

  GetPostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

final class GetPostsError extends GetPostsState {
  final String message;

  GetPostsError(this.message);

  @override
  List<Object> get props => [message];
}

final class GetPostsLoading extends GetPostsState {}
