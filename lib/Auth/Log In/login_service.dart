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