part of 'get_memebers_cubit.dart';

sealed class MemebersState extends Equatable {
  const MemebersState();

  @override
  List<Object> get props => [];
}

final class MemebersInitial extends MemebersState {}

final class MemebersLoading extends MemebersState {}

final class MemebersLoaded extends MemebersState {
  final List<User> users;

  MemebersLoaded(this.users);

  @override
  List<Object> get props => [users];
}

final class MemebersError extends MemebersState {
  final String message;

  MemebersError(this.message);

  @override
  List<Object> get props => [message];
}
