import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Progress.dart';

abstract class ProgressLocalDataSource {
  Future<void> cacheProgress(List<ProgressModel> progress);
  Future<List<ProgressModel>> getCachedProgress();
}

class ProgressLocalDataSourceImpl implements ProgressLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProgressLocalDataSourceImpl(this.sharedPreferences);


  @override
  Future<void> cacheProgress(List<ProgressModel> progress) {
    return sharedPreferences.setString(
      'CACHED_PROGRESS',
      json.encode(
        progress
            .map<Map<String, dynamic>>((progress) => progress.toJson())
            .toList(),
      ),
    );
  }

  @override
  Future<List<ProgressModel>> getCachedProgress() {
    final jsonString = sharedPreferences.getString('CACHED_PROGRESS');
    if (jsonString != null) {
      return Future.value((json.decode(jsonString) as List<dynamic>)
          .map<ProgressModel>((item) => ProgressModel.fromJson(item))
          .toList());
    } else {
      throw EmptyCacheException();
    }
  }

}
