import 'dart:convert';
import 'package:http/http.dart' as http;
import '../app_config.dart';
import '../constants.dart';

Future<void> loginWithEmailPassword({
  required String email,
  required String password,
}) async {
  final url = Uri.parse('${AppConfig.Auth_Api}/login');

  try {
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        ApiFields.logInMethod: 'email',
        ApiFields.email: email,
        ApiFields.password: password,
      },
    );

    if (response.statusCode == HttpStatusCodes.success) {
      final responseBody = json.decode(response.body);
      print('Login successful. Response Body: $responseBody');
    } else {
      print('Login failed. Status Code: ${response.statusCode}');
      print('Reason Phrase: ${response.reasonPhrase}');
      print('Response Body: ${response.body}');
    }
  } catch (e) {
    print('Something went wrong. Please try again.');
    print(e.toString());
  }
}


Future<void> loginWithUserNamePassword({
  required String username,
  required String password,
}) async {
  final url = Uri.parse('${AppConfig.Auth_Api}/login');

  try {
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        ApiFields.logInMethod: 'username',
        ApiFields.username: username,
        ApiFields.password: password,
      },
    );

    if (response.statusCode == HttpStatusCodes.success) {
      final responseBody = json.decode(response.body);
      print('Login successful. Response Body: $responseBody');
    } else {
      print('Login failed. Status Code: ${response.statusCode}');
      print('Reason Phrase: ${response.reasonPhrase}');
      print('Response Body: ${response.body}');
    }
  } catch (e) {
    print('Something went wrong. Please try again.');
    print(e.toString());
  }
}

Future<void> loginWithPhoneNumber({required String phoneNumber}) async {
  final url = Uri.parse('${AppConfig.Auth_Api}/login');
  final headers = {'Accept': 'application/json'};

  final request = http.MultipartRequest('POST', url);
  request.headers.addAll(headers);
  request.fields.addAll({
    'login_method': 'phone',
    'phone': phoneNumber,
  });

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  } catch (e) {
    print('Something went wrong. Please try again.');
    print(e.toString());
  }
}

// -- OTP

Future<void> requestOTPWithPhoneNumber({required String phoneNumber, required String otp}) async {
  final url = Uri.parse('${AppConfig.Auth_Api}/otp');
  final headers = {'Accept': 'application/json'};

  final request = http.MultipartRequest('POST', url);
  request.headers.addAll(headers);
  request.fields.addAll({
    'phone': phoneNumber,
    'otp': otp,
  });

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  } catch (e) {
    print('Something went wrong. Please try again.');
    print(e.toString());
  }
}