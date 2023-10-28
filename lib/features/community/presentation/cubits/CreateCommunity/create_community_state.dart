part of 'create_community_cubit.dart';

sealed class CreateCommunityState extends Equatable {
  const CreateCommunityState();

  @override
  List<Object> get props => [];
}

final class CreateCommunityInitial extends CreateCommunityState {}

final class CreateLoadingState extends CreateCommunityState {}
final class CreatedSuccessfullyState extends CreateCommunityState {
  final Community community;

  CreatedSuccessfullyState(this.community);
}
final class CreateErrorState extends CreateCommunityState {
  final String message;

  CreateErrorState(this.message);
}
