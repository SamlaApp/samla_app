part of 'add_comment_cubit.dart';

sealed class AddCommentState extends Equatable {
  const AddCommentState();

  @override
  List<Object> get props => [];
}

final class AddCommentInitial extends AddCommentState {}

final class AddCommentLoading extends AddCommentState {}

final class AddCommentSuccess extends AddCommentState {
  final Comment comment;

  AddCommentSuccess(this.comment);

  @override
  List<Object> get props => [comment];
}

final class AddCommentError extends AddCommentState {
  final String message;

  AddCommentError(this.message);

  @override
  List<Object> get props => [message];
}
