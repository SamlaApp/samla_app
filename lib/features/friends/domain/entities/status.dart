import 'package:equatable/equatable.dart';

class FriendStatus extends Equatable {
  final int id;
  final int userId;
  final int friendId;
  final String status;

  FriendStatus({required this.id, required this.userId, required this.friendId, required this.status});
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
