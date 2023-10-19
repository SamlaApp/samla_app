import '../../domain/entities/notification.dart';

class NotificationModel extends Notification_ {
  NotificationModel({
    required super.id,
    required super.title,
    required super.message,
    required super.isRead,
    required super.createdAt,
  });


  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      isRead: json['is_read'] == 1 ? true : false,
      createdAt: json['created_at'],
    );
  }

  factory NotificationModel.fromEntity(Notification_ notification) {
    return NotificationModel(
      id: notification.id,
      title: notification.title,
      message: notification.message,
      isRead: notification.isRead,
      createdAt: notification.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'is_read': isRead! ? 1 : 0, // check if it is null (!) then apply a condition (if true then 1 else 0)
      'created_at': createdAt,
    };
  }

  // fromJson, toJson omitted for brevity


}