import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/main/data/models/Progress.dart';

import '../../../../core/network/samlaAPI.dart';
import '../../../../main.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';


const BASE_URL = 'https://samla.mohsowa.com/api';

abstract class ProgressRemoteDataSource {
  Future<List<ProgressModel>> getAllProgress();
}

class ProgressRemoteDataSourceImpl implements ProgressRemoteDataSource {
  final http.Client client;

  ProgressRemoteDataSourceImpl({required this.client});

  Future<http.StreamedResponse> _request(
      {Map<String, String>? data,
        http.MultipartFile? file,
        required String endPoint,
        required String method,
        bool autoLogout = true}) async {
    final token = authBloc.user.accessToken;
    // final token = 'random';
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(method, Uri.parse(BASE_URL + endPoint));

    if (data != null) {
      request.fields.addAll(data);
    }

    if (file != null) {
      request.files.add(file);
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await client.send(request);
    if (response.statusCode == 401) {
      if (autoLogout) {
        authBloc.add(LogOutEvent(navigatorKey.currentState!.context));
      } else {
        throw UnauthorizedException();
      }
    } else {
      return response;
    }
    return response;
  }


  @override
  Future<List<ProgressModel>> getAllProgress() async {
    final response = await _request(
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