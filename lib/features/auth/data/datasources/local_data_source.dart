import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:samla_app/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<Unit> cacheUser(UserModel userToCache);
  Future<Unit> cacheDeviceToken(String token);
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});
  
  @override
  Future<Unit> cacheUser(UserModel userToCache) {
    final jsonUser = userToCache.toJson();
    sharedPreferences.setString('user', json.encode(jsonUser));
    return Future.value(unit);
  }

  @override
  Future<Unit> cacheDeviceToken(String token) {
    sharedPreferences.setString('deviceToken', token);
    return Future.value(unit);
  }
}
