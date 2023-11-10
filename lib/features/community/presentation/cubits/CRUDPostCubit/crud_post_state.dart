part of 'crud_post_cubit.dart';

sealed class CrudPostState extends Equatable {
  const CrudPostState();

  @override
  List<Object> get props => [];
}

final class CrudPostInitial extends CrudPostState {}

final class CrudPostLoading extends CrudPostState {}

final class CrudPostCreated extends CrudPostState {
  final Post post;

  CrudPostCreated(this.post);
}

final class CrudPostError extends CrudPostState {
  final String message;

  CrudPostError(this.message);
}
