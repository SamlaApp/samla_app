import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:samla_app/features/friends/domain/entities/message.dart';

import '../../../../core/error/failures.dart';

abstract class MessageRepository {
  Future<Either<Failure, List<Message>>> sendMessage({
    required int friend_id,
    String? message,
    required String type,
    File? file,
  });

  Future<Either<Failure, List<Message>>> getMessages(int freindship_id);
}
