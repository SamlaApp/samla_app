import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:samla_app/features/notifications/data/models/notification_model.dart';

abstract class LocalDataSource {
  Future<Unit> cacheNotifications(NotificationModel notificationsToCache);
  Future<NotificationModel> getCachedNotifications();
  void clearCache();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cacheNotifications(NotificationModel notificationsToCache) {
    final jsonNotifications = notificationsToCache.toJson();
    sharedPreferences.setString('notifications', json.encode(jsonNotifications));
    return Future.value(unit);
  }

  @override
  Future<NotificationModel> getCachedNotifications() {
    final jsonNotifications = sharedPreferences.getString('notifications');
    if (jsonNotifications != null) {
      final notifications = NotificationModel.fromJson(json.decode(jsonNotifications));
      return Future.value(notifications);
    } else {
      throw EmptyCacheException(message: 'no cached notifications found');
    }
  }

  @override
  void clearCache() {
    sharedPreferences.remove('notifications');
  }

}




