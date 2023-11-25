part of 'steps_cubit.dart';

class SensorState extends Equatable {
  const SensorState();

  @override
  List<Object> get props => [];
}

class SensorError extends SensorState {
  final String message;

  const SensorError(this.message);
}

class SensorWorks extends SensorState {
  final int reads;
  const SensorWorks(this.reads);

  @override
  List<Object> get props => [reads];
}
