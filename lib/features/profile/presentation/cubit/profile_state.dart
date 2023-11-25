part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});
}

class ProfileLoading extends ProfileState {}

class UserGoalInitial extends ProfileState {}

class UserGoalErrorState extends ProfileState {
  final String message;

  const UserGoalErrorState({required this.message});
}

class UserGoalloaded extends ProfileState {
  final UserGoals userGoal;

  const UserGoalloaded({required this.userGoal});
}

// ProfileAvatarLoading
class ProfileAvatarLoading extends ProfileState {}

// ProfileAvatarLoaded
class UserAvatarLoaded extends ProfileState {
  final File imageFile;

  const UserAvatarLoaded({required this.imageFile});
}

// ProfileAvatarError
class UserAvatarErrorState extends ProfileState {
  final String message;

  const UserAvatarErrorState({required this.message});
}


class UserSettingLoading extends ProfileState {}

class UpdateUserSettingLoaded extends ProfileState {
  final User user;

  const UpdateUserSettingLoaded({required this.user});
}

class UpdateUserSettingState extends ProfileState {
  final String message;

  const UpdateUserSettingState({required this.message});
}


