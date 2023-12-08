import 'package:equatable/equatable.dart';
import 'dart:io';

class Message extends Equatable {
  final int? id;
  final int friend_id;
  final int? sender_id;
  final String? message;

  // final String? imageURL;
  final String type;

  // final updated_at

  const Message({
    required this.id,
    required this.sender_id,
    required this.friend_id,
    required this.message,
    required this.type,
  });

  @override
  List<Object?> get props => [id, friend_id, message, type, sender_id];
}
