import 'dart:convert';
import 'package:http/http.dart' as http;
import '../app_config.dart';
import '../constants.dart';

class RegisterService {
  Future<void> register({
    required String name,
    required String email,
    required String username,
    required String phone,
    required String dateOfBirth,
    required String password,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('${AppConfig.sign_up_api}/register'));
      request.headers['Accept'] = 'application/json';
      request.fields.addAll({
        ApiFields.name: name,
        ApiFields.email: email,
        ApiFields.username: username,
        ApiFields.phone: phone,
        ApiFields.dateOfBirth: dateOfBirth,
        ApiFields.password: password,
      });

      var response = await request.send();

      if (response.statusCode == HttpStatusCodes.success) {
        final responseBody = await response.stream.bytesToString();
        print("Response Body: $responseBody");
      } else if (response.statusCode == HttpStatusCodes.validationError) {
        final responseBody = await response.stream.bytesToString();
        final responseJson = json.decode(responseBody);
        print("Failed with validation errors: $responseJson");
      } else {
        final responseBody = await response.stream.bytesToString();
        print("Response Body: $responseBody");
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Something went wrong. Please try again.');
    }
  }
}
