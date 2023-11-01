part of 'explore_cubit.dart';

sealed class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object> get props => [];
}

final class ExploreInitial extends ExploreState {}

final class ExploreLoading extends ExploreState {}

final class ExploreLoaded extends ExploreState {
  final List<Community> communities;

  ExploreLoaded(this.communities);
}

final class ExploreError extends ExploreState {
  final String message;

  ExploreError(this.message);
}

class ExploreEmpty extends ExploreState {}
