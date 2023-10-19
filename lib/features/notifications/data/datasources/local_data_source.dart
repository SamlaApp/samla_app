import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:samla_app/features/notifications/data/models/notification_model.dart';

abstract class NotificationLocalDataSource {
  Future<Unit> cacheNotifications(List<NotificationModel> notificationsToCache);
  Future<List<NotificationModel>> getCachedNotifications();
  void clearCache();
}

class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  final SharedPreferences sharedPreferences;

  NotificationLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cacheNotifications(
      List<NotificationModel> notificationsToCache) {
    List<Map<String, dynamic>> notificationJsonList =
        notificationsToCache.map((notification) {
      return notification.toJson();
    }).toList();
    sharedPreferences.setString(
        'notifications', json.encode(notificationJsonList));
    return Future.value(unit);
  }

  @override
  Future<List<NotificationModel>> getCachedNotifications() {
    final notificationJsonList = sharedPreferences.getString('notifications');

    dynamic notificationList;
    if (notificationJsonList != null) {
      notificationList = json.decode(notificationJsonList);
    }

    if (notificationList != null && notificationList.isNotEmpty) {
      List<NotificationModel> notificationModels = [];

      notificationList.forEach((json) {
        notificationModels.add(NotificationModel.fromJson(json));
      });

      return Future.value(notificationModels);
    } else {
      throw EmptyCacheException(message: 'no cached notifications found');
    }
  }

  @override
  void clearCache() {
    sharedPreferences.remove('notifications');
  }
}
