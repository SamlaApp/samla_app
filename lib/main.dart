import 'dart:convert';
import 'package:http/http.dart' as http;

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
      var request = http.MultipartRequest('POST', Uri.parse('${AppConfig.apiUrl}/register'));
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

// app_config.dart
class AppConfig {
  static const String apiUrl = 'https://samla.mohsowa.com/api';
}

// constants.dart
class ApiFields {
  static const String name = 'name';
  static const String email = 'email';
  static const String username = 'username';
  static const String phone = 'phone';
  static const String dateOfBirth = 'date_of_birth';
  static const String password = 'password';
}

class HttpStatusCodes {
  static const int success = 200;
  static const int validationError = 422;
}

// main.dart
void main() {
  final registerService = RegisterService();

  // Test
  registerService.register(
    name: 'BoSaleh3',
    email: 'BoSaleh@Test3.com',
    username: 'BoSaleh3',
    phone: '96656666135423',
    dateOfBirth: '2000-09-13',
    password: '12345678',
  );
}
