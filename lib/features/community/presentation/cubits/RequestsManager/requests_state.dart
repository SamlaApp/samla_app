part of 'requests_cubit.dart';

sealed class RequestsState extends Equatable {
  const RequestsState();

  @override
  List<Object> get props => [];
}

final class RequestsCubitsInitial extends RequestsState {}

final class RequestsCubitsLoading extends RequestsState {}

final class RequestsCubitsLoaded extends RequestsState {
  final List<RequestToJoin> requests;

  RequestsCubitsLoaded(this.requests);
}

final class RequestsCubitsError extends RequestsState {
  final String message;

  RequestsCubitsError(this.message);
}
