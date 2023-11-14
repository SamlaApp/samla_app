import 'package:samla_app/features/auth/domain/entities/user.dart';

enum AcceptedStatus { accepted, rejected, pending }

class RequestToJoin {
  final int id;
  final int userId;
  final int communityID;
  final String createdAt;
  final AcceptedStatus status;
  final User user;
  RequestToJoin({
    required this.id,
    required this.userId,
    required this.communityID,
    required this.status,
    required this.createdAt,
    required this.user,
  });

  factory RequestToJoin.fromJson(Map<String, dynamic> json, User user) => RequestToJoin(
        id: json["id"],
        userId: json["user_id"],
        communityID: json["community_id"],
        status: json["accepted"] == 1
            ? AcceptedStatus.accepted
            : json["rejected"] == 1
                ? AcceptedStatus.rejected
                : AcceptedStatus.pending,
        createdAt: json["created_at"],
        user: user,
      );
}
