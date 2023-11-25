part of 'steps_log_cubit.dart';

sealed class StepsLogState extends Equatable {
  const StepsLogState();

  @override
  List<Object> get props => [];
}

final class StepsLogInitial extends StepsLogState {}

final class StepsLogLoaded extends StepsLogState {
  final List<StepsLog> stepsLog;

  const StepsLogLoaded(this.stepsLog);

  @override
  List<Object> get props => [stepsLog];
  
}


final class StepsLogStateError extends StepsLogState {
  final String message;

  const StepsLogStateError(this.message);

  @override
  List<Object> get props => [message];
  
}