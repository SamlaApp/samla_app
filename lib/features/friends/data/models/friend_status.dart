import 'package:samla_app/features/friends/domain/entities/status.dart';

class FriendStatusModel extends FriendStatus {
  FriendStatusModel(
      {required super.id,
      required super.userId,
      required super.friendId,
      required super.status});

  factory FriendStatusModel.fromJson(Map<String, dynamic> json) {
    return FriendStatusModel(
        id: json['id'],
        userId: json['user_id'],
        friendId: json['friend_id'],
        status: json['status']);
  }
}
