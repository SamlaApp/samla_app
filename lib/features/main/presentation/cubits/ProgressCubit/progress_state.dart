part of 'progress_cubit.dart';

sealed class ProgressState extends Equatable {
  const ProgressState();

  @override
  List<Object> get props => [];
}

final class ProgressInitial extends ProgressState {}

final class ProgressLoadingState extends ProgressState {}

final class ProgressLoadedState extends ProgressState {
  final List<Progress> progress;

  ProgressLoadedState(this.progress);
}

final class ProgressErrorState extends ProgressState {
  final String message;

  ProgressErrorState(this.message);
}
