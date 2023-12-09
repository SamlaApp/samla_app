part of 'explore_cubit.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object> get props => [];
}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreError extends ExploreState {
  final String message;

  const ExploreError({required this.message});
}

class ExploreLoaded extends ExploreState {
  final List<User> users;

  const ExploreLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class ExploreEmpty extends ExploreState {}
