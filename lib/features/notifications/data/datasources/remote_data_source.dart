import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:samla_app/core/error/exceptions.dart';
import '../models/notification_model.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart';

const BASE_URL = 'https://samla.mohsowa.com/api/notification';

final user = getUser();

abstract class RemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  Future<http.StreamedResponse> _request(
      Map<String, String> data, String endPoint, String method) async {

    // get token from user

    var token = user!.accessToken;

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(method, Uri.parse(BASE_URL + endPoint));
    request.fields.addAll(data);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }

  @override
  Future<List<NotificationModel>> getNotifications() async {
    final response = await _request({}, '/get', 'GET');
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final notificationsJson = json.decode(responseBody)['notifications'];
      return notificationsJson
          .map<NotificationModel>((json) => NotificationModel.fromJson(json))
          .toList();
    } else {
      print(json.decode(responseBody)['message']);
      throw ServerException(message: json.decode(responseBody)['message']);
    }
  }


}