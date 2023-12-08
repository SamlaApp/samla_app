import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/message_model.dart';

abstract class LocalDataSource {}

class LocalDataSourceImpl implements LocalDataSource {
  // sharedPreferences
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({
    required this.sharedPreferences,
  });

  // cacheMessages(messages, friend_id);
  Future<void> cacheMessages(List<MessageModel> messages, int friend_id) async {
    final messagesJson = json.encode(messages.map((e) => e.toJson()).toList());
    await sharedPreferences.setString('messages_$friend_id', messagesJson);
  }

  // localDataSource.getCachedMessages(friend_id);
  Future<List<MessageModel>> getCachedMessages(int friend_id) async {
    final messagesJson = sharedPreferences.getString('messages_$friend_id');
    if (messagesJson != null) {
      final messages = json.decode(messagesJson).map<MessageModel>((message) {
        return MessageModel.fromJson(message);
      }).toList();
      return messages;
    } else {
      throw EmptyCacheException(message: 'No messages cached');
    }
  }
}
