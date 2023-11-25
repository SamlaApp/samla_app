part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});
}

class ProfileLoading extends ProfileState {}

class UserGoalInitial extends ProfileState {}

class UserGoalErrorState extends ProfileState {
  final String message;

  UserGoalErrorState({required this.message});
}

class UserGoalloaded extends ProfileState {
  final UserGoals userGoal;

  UserGoalloaded({required this.userGoal});
}
