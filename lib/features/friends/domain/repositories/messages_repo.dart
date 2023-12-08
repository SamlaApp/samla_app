import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/message_model.dart';

abstract class MessageRepository {
  Future<Either<Failure, List<MessageModel>>> sendMessage(
      {required int friend_id, required String message, required String type});

  Future<Either<Failure, List<MessageModel>>> getMessages(
      {required int friend_id});
}
