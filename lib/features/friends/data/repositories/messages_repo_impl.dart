import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:samla_app/features/friends/domain/entities/message.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/messages_repo.dart';

import '../datasources/remoteDataSource.dart';

import '../datasources/localDataSource.dart';
import '../models/message_model.dart';

class MessageRepositoryImpl extends MessageRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MessageRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Message>>> sendMessage({
    required int friend_id,
    String? message,
    required String type,
    File? file,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final msg = await remoteDataSource.sendMessage(
          friend_id: friend_id,
          message: message,
          type: type,
          file: file,
        );
        return Right(msg);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getMessages(
      int friendship_id) async {
    if (await networkInfo.isConnected) {
      try {
        final messages = await remoteDataSource.getMessages(friendship_id);
        return Right(messages);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      //TODO: get it from cache instead
      return Left(ServerFailure(message: 'No internet connection'));
    }
  }
}
