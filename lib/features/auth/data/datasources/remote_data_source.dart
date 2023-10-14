import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/auth/data/models/user_model.dart';

const BASE_URL = 'https://samla.mohsowa.com/api';

abstract class RemoteDataSource {
  Future<UserModel> loginWithEmail(String email, String password);

  Future<UserModel> loginWithUsername(String username, String password);

  Future<Unit> loginWithPhoneNumber(String phoneNumber);

  Future<UserModel> signup({
    required String name,
    required String email,
    required String username,
    required String phone,
    required String dateOfBirth,
    required String password,
  });

  Future<UserModel> sendOTP(String phoneNumber, String otp);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> loginWithEmail(String email, String password) async {
    final data = {
      'login_method': 'email',
      'email': email,
      'password': password,
    };
    final response = await _request(data, '/login', 'POST');
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final userJson = json.decode(responseBody)['user'];
      userJson['access_token'] = json.decode(responseBody)['access_token'];
      return UserModel.fromJson(userJson);
    } else {
      print(json.decode(responseBody)['message']);
      throw ServerException(message: json.decode(responseBody)['message']);
    }
  }

  @override
  Future<Unit> loginWithPhoneNumber(String phoneNumber) async {
    final data = {
      'login_method': 'phone',
      'phone': phoneNumber,
    };
    final response = await _request(data, '/login', 'POST');
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException(message: json.decode(responseBody)['message']);
    }
  }

  @override
  Future<UserModel> loginWithUsername(String username, String password) async {
    final data = {
      'login_method': 'username',
      'username': username,
      'password': password,
    };
    final response = await _request(data, '/login', 'POST');
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final userJson = json.decode(responseBody)['user'];
      userJson['access_token'] = json.decode(responseBody)['access_token'];
      return UserModel.fromJson(userJson);
    } else {
      print(json.decode(responseBody)['message']);
      throw ServerException(message: json.decode(responseBody)['message']);
    }
  }

  @override
  Future<UserModel> signup({
    required String name,
    required String email,
    required String username,
    required String phone,
    required String dateOfBirth,
    required String password,
  }) async {
    final data = {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'date_of_birth': dateOfBirth,
      'username': username,
    };
    final response = await _request(data, '/register', 'POST');
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      final userJson = json.decode(responseBody)['user'];
      userJson['access_token'] = json.decode(responseBody)['access_token'];
      return UserModel.fromJson(userJson);
    } else {
      print(json.decode(responseBody));
      throw ServerException(message: json.decode(responseBody)['message']);
    }
  }

  @override
  Future<UserModel> sendOTP(String phoneNumber, String otp) async {
    final data = {
      'otp': otp,
      'phone': phoneNumber,
    };
    final response = await _request(data, '/otp', 'POST');
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final userJson = json.decode(responseBody)['user'];
      userJson['access_token'] = json.decode(responseBody)['access_token'];
      return UserModel.fromJson(userJson);
    } else {
      print(json.decode(responseBody)['message']);
      throw ServerException(message: json.decode(responseBody)['message']);
    }
  }

  Future<http.StreamedResponse> _request(
      Map<String, String> data, String endPoint, String method) async {
    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest(method, Uri.parse(BASE_URL + endPoint));
    request.fields.addAll(data);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }
}

