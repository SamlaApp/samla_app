import 'dart:io';

import '../../domain/entities/message.dart';

class MessageModel extends Message {
  final int? id;
  final int friend_id;
  final int? sender_id;
  final String? message;
  final String type;

  const MessageModel({
    required this.id,
    required this.friend_id,
    required this.sender_id,
    required this.message,
    required this.type,
  }) : super(
          id: id,
          sender_id: sender_id,
          friend_id: friend_id,
          message: message,
          type: type,
        );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      friend_id: json['friend_id'],
      sender_id: json['sender_id'],
      message: json['message'],
      type: json['type'],
    );
  }

  factory MessageModel.fromEntity(Message message) {
    return MessageModel(
      id: message.id,
      sender_id: message.sender_id,
      friend_id: message.friend_id,
      message: message.message,
      type: message.type,
    );
  }

  Map<String, String> toJson() {
    return {
      'id': id.toString(),
      'sender_id': sender_id.toString(),
      'friend_id': friend_id.toString(),
      'message': message.toString(),
      'type': type,
    };
  }
}
