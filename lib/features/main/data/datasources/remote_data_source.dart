import 'dart:convert';

import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/main/data/models/Progress.dart';

import '../../../../core/network/samlaAPI.dart';

abstract class ProgressRemoteDataSource {
  Future<List<ProgressModel>> getAllProgress();
}

class ProgressRemoteDataSourceImpl implements ProgressRemoteDataSource {
  @override
  Future<List<ProgressModel>> getAllProgress() async {
    final response = await samlaAPI(
      endPoint: '/progress/get_all',
      method: 'GET',
    );
    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      final List<ProgressModel> progress = [];
      final parsed = jsonDecode(body)['user_progress'];
      for (var item in parsed) {
        progress.add(ProgressModel.fromJson(item));
      }

      return progress;
    } else {
      throw ServerException(message: 'Server Error');
    }
  }
}
