import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import '../models/notification_model.dart';
// import 'package:samla_app/features/auth/auth_injection_container.dart';

const BASE_URL = 'https://samla.mohsowa.com/api/notification';


abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final http.Client client;

  NotificationRemoteDataSourceImpl({required this.client});

  Future<http.StreamedResponse> _request(
      Map<String, String> data, String endPoint, String method) async {
    // get token from user
    final user = sl.get<AuthBloc>().user;
    var token = user.accessToken;
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
    // print(responseBody);

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

// // test
// main() async {
//   try {
//     final client = http.Client();
//     final remoteDataSource = NotificationRemoteDataSourceImpl(client: client);
//     final notifs = await remoteDataSource.getNotifications();
//     // check the type or returned object
//     print('${notifs[0].title} \n ${notifs[1].title}');
//     print(notifs.runtimeType);
//   } on ServerException catch (e) {
//     print(e);
//   }
// }
