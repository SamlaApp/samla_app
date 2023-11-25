part of 'history_cubit.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoadingState extends HistoryState {}

class HistoryLoadedState extends HistoryState {
  final List<ExerciseHistory> history;

  const HistoryLoadedState(this.history);

  @override
  List<Object> get props => [history];
}

class HistoryEmptyState extends HistoryState {}

class HistoryErrorState extends HistoryState {
  final String message;

  const HistoryErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class NewHistoryLoadedState extends HistoryState {
}