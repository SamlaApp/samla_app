import 'dart:convert';

import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/main/data/models/Progress.dart';

import '../../../../core/network/samlaAPI.dart';

abstract class RemoteDataSource {
  Future<List<ProgressModel>> getAllProgress();
  Future<int> getStreak();
  Future<void> sendProgress(ProgressModel progress);
}

class ProgressRemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<List<ProgressModel>> getAllProgress() async {
    final response = await samlaAPI(
      endPoint: '/progress/get_all',
      method: 'GET',

    );
          final body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final List<ProgressModel> progress = [];
      final parsed = jsonDecode(body)['user_progress'];
      for (var item in parsed) {
        progress.add(ProgressModel.fromJson(item));
      }

      return progress;
    } else {
      
      throw ServerException(message: json.decode(body)['message']);
    }
  }

  @override
  Future<int> getStreak() async {
    final response = await samlaAPI(
      endPoint: '/user/streak/get',
      method: 'GET',
    );
    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      final parsed = jsonDecode(body)['streak'];
      return parsed;
    } else {
      throw ServerException(message: 'Server Error');
    }
  }

  @override
  Future<void> sendProgress(ProgressModel progress) async {
    final res = await samlaAPI(
      endPoint: '/progress/set',
      method: 'POST',
      data: progress.toJson(),
    );
    if (res.statusCode != 200) {
      throw ServerException(message: 'Server Error');
    }
  }
}
