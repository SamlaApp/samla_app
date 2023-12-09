part of 'friend_ship_cubit.dart';

sealed class FriendShipState extends Equatable {
  const FriendShipState();

  @override
  List<Object> get props => [];
}

final class FriendShipInitial extends FriendShipState {}

class FriendShipError extends FriendShipState {
  final String message;
  FriendShipError({ required this.message});

  @override
  List<Object> get props => [message];
}

class FriendShipLoaded extends FriendShipState {
  final FriendStatus status;
  FriendShipLoaded(this.status);

  @override
  List<Object> get props => [status];
}

class FriendShipLoading extends FriendShipState {
  const FriendShipLoading();
}
