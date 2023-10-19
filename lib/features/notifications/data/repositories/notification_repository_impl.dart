import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/core/network/network_info.dart';
import 'package:samla_app/features/notifications/data/datasources/local_data_source.dart';
import 'package:samla_app/features/notifications/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/notifications/domain/entities/notification.dart';
import 'package:samla_app/features/notifications/data/models/notification_model.dart';
import 'package:samla_app/features/notifications/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;
  final NotificationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NotificationRepositoryImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, List<Notification_>>> getNotifications() async {
    if (await networkInfo.isConnected) {
      try {
        final notifications = await remoteDataSource.getNotifications();
        //cache notifications
        if (notifications.isNotEmpty) {
          await localDataSource.cacheNotifications(notifications);
        }

        return Right(notifications);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Notification_>>> getCachedNotifications() async {
    try {
      final cachedNotifications =
          await localDataSource.getCachedNotifications();
      return Right(cachedNotifications);
    } on EmptyCacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
