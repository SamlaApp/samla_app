import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/community/domain/entities/Comment.dart';
import 'package:samla_app/features/community/domain/entities/Post.dart';
import 'package:samla_app/features/community/domain/repositories/post_repository.dart';

part 'add_comment_state.dart';

class AddCommentCubit extends Cubit<AddCommentState> {
  AddCommentCubit(this.postRepository) : super(AddCommentInitial());
  final PostRepository postRepository;

  Future<void> addComment(Comment comment) async {
    emit(AddCommentLoading());
    final failureOrComment = await postRepository.commentPost(comment);
    failureOrComment.fold(
      (failure) => emit(AddCommentError(failure.message)),
      (comment) {
        emit(AddCommentSuccess(comment));
      },
    );
  }
}
