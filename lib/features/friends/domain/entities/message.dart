import 'package:equatable/equatable.dart';
import 'dart:io';

class Message extends Equatable {
  final int? id;
  final int friend_id;
  final int? sender_id;
  final String? message;

  final String? imageURL;
  final File? imageFile;
  final String type;

  // final updated_at

  const Message({
    this.imageFile,
    this.imageURL,
    this.id,
    this.sender_id,
    required this.friend_id,
    this.message,
    required this.type,
  });

  @override
  List<Object?> get props => [id, friend_id, message, type, sender_id,imageFile, imageURL ];
}
