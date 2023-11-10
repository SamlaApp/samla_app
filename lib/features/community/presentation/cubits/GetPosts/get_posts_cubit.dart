import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/community/domain/entities/Post.dart';
import 'package:samla_app/features/community/domain/repositories/post_repository.dart';

part 'get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  GetPostsCubit(this.repository) : super(GetPostsInitial());

  final PostRepository repository;

  Future<void> getPosts(int communityID) async {
    emit(GetPostsLoading());
    final failureOrPosts = await repository.getAllPosts(communityID);
    failureOrPosts.fold(
      (failure) => emit(GetPostsError(failure.message)),
      (posts) => emit(GetPostsLoaded(posts)),
    );
  }

  Future<void> createPost(Post post) async {
    emit(GetPostsLoading());
    final failureOrPost = await repository.createPost(post);
    failureOrPost.fold(
      (failure) => emit(GetPostsError(failure.message)),
      (post) => emit(GetPostsLoaded([post])),
    );
  }

  
}

