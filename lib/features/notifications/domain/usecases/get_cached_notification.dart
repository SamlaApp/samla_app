import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/notifications/domain/entities/notification.dart';
import 'package:samla_app/features/notifications/domain/repositories/notification_repository.dart';

class GetCachedNotification {
  final NotificationRepository repository;

  GetCachedNotification(this.repository);

  Future<Either<Failure, Notification>> call() async {
    return await repository.getCachedNotifications();
  }
}