import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/community/domain/repositories/post_repository.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this.repository) : super(PostInitial());

  final PostRepository repository;

  showComments() {
    if (state is PostComments) {
      emit(PostInitial());
      return;
    }
    emit(PostComments());
  }
}
