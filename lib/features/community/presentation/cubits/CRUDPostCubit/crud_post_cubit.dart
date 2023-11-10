import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/community/domain/entities/Post.dart';
import 'package:samla_app/features/community/domain/repositories/post_repository.dart';

part 'crud_post_state.dart';

class CrudPostCubit extends Cubit<CrudPostState> {
  final int communityId;
  CrudPostCubit(this.communityId, this.repository) : super(CrudPostInitial());
  final PostRepository repository;

  void createPost(Post post) async {
    emit(CrudPostLoading());
    final failureOrPost = await repository.createPost(post);
    failureOrPost.fold(
      (failure) => emit(CrudPostError(failure.message)),
      (post) => emit(CrudPostCreated(post)),
    );

  }
}
