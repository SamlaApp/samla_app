part of 'send_progress_cubit.dart';

sealed class SendProgressState extends Equatable {
  const SendProgressState();

  @override
  List<Object> get props => [];
}

final class SendProgressInitial extends SendProgressState {}

final class SendProgressLoading extends SendProgressState {}

final class SendProgressError extends SendProgressState {
  final String message;

  const SendProgressError(this.message);

  @override
  List<Object> get props => [message];
}

final class SendProgressSuccess extends SendProgressState {}

