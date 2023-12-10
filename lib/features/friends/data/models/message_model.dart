import 'dart:io';

import '../../domain/entities/message.dart';

class MessageModel extends Message {
  const MessageModel({
    super.imageURL,
    super.imageFile,
    super.id,
    required super.friend_id,
    super.sender_id,
    super.message,
    required super.type,
    super.created_at
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    if (json['image'] != null &&
        !json['image'].isEmpty &&
        !json['image'].contains('http')) {
      json['image'] =
          'https://samla.mohsowa.com/api/chat/image/' + json['image'];
    }
    return MessageModel(
      imageURL: json['image'],
      id: json['id'],
      friend_id: json['friend_id'],
      sender_id: json['user_id'],
      message: json['message'],
      type: json['type'],
      created_at: json['created_at']
    );
  }

  factory MessageModel.fromEntity(Message message) {
    return MessageModel(
      id: message.id,
      sender_id: message.sender_id,
      friend_id: message.friend_id,
      message: message.message,
      type: message.type,
      imageFile: message.imageFile,
      imageURL: message.imageURL,
      created_at: message.created_at
    );
  }

  Map<String, String> toJson() {
    return {
      'id': id.toString(),
      'user_id': sender_id.toString(),
      'friend_id': friend_id.toString(),
      'message': message.toString(),
      'type': type,
      'image': imageURL.toString(),
      'created_at': created_at.toString()
    };
  }
}
