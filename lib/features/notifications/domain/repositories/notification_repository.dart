import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import '../entities/notification.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<Notification>>> getNotifications();
  Future<Either<Failure, Notification>> getCachedNotifications();
}