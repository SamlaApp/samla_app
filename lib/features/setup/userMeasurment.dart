// import 'package:samla_app/features/auth/data/datasources/remote_data_source.dart';

import 'dart:convert';
// import '.../app_config.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class userMeasurment {
  final base_api = 'https://samla.mohsowa.com/api/goals';

  final update_gender_Api = 'https://samla.mohsowa.com/api/goals/update_gender';
  final update_height_Api = 'https://samla.mohsowa.com/api/goals/update_height';
  final update_steps_Api =
      'https://samla.mohsowa.com/api/goals/update_steps_target';
  final update_weight_Api =
      'https://samla.mohsowa.com/api/goals/update_weight_target';
  final update_calories_Api =
      'https://samla.mohsowa.com/api/goals/update_calories_target';

  final get_goals_Api = 'https://samla.mohsowa.com/api/goals/get_goals';
  final finish_goals_Api =
      'https://samla.mohsowa.com/api/goals/finish_set_goals';
  final has_goal_Api = 'https://samla.mohsowa.com/api/goals/has_goals';

  int weight = 0, height = 0, calories = 0, steps = 0;
  String gender = '';

  Future<void> updateGender({required String gender}) async {
    try {
      if (gender == null) {
        throw Exception('Please enter your gender!');
      }

      final data = {'gender': gender};

      final response = await _request(data, update_gender_Api, 'POST');
      final responseBody = await response.stream.bytesToString();

      // final response = await _dio.post(Uri.parse('${AppConfig.Auth_Api}/stepsGoal').toString(),//toString bcs dio need it as String
      // final data = {
      //   'gender': gender,
      // };

      // print("gender = " + gender);
      // final request = http.Request('POST', Uri.parse(update_gender_Api));
      // print("uri : " + Uri.parse(update_gender_Api).toString());
      // request.headers['Content-Type'] = 'application/json';
      // request.headers['Access-Control-Allow-Origin'] = '*';
      // request.headers['Access-Control-Allow-Headers'] = '*';
      // request.headers['Access-Control-Allow-Methods'] =
      //     'POST,GET,DELETE,PUT,OPTIONS';

      // request.body = jsonEncode(data);
      // print(jsonEncode(data));
      // final response = await request.send();
      // final responseString = await response.stream.bytesToString();
      // // response = aw;ait http.post(
      // //   Uri.parse(update_gender_Api),
      // //   body: {
      //     'gender': gender.toString(),
      //   },
      // );
      if (response.statusCode == 200) {
        print('User data saved successfully');
      } else {
        print('Failed to save user data. Status code: ${response.statusCode}');
      }
    } catch (error, stack) {
      print('Error saving user data: $error');
      print('Stack trace:\n $stack');
    }
  }

  Future<void> updateheight({required int height}) async {
    try {
      if (height == null) {
        throw Exception('Please enter your height!');
      }
      if (height.isNegative) {
        print('Please enter height as positive number!');
      }
      if (!isInteger(height)) {
        print('Please enter height as an integer number!');
      }

      final data = {'height': height.toString()};

      final response = await _request(data, update_height_Api, 'POST');
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print('User data saved successfully');
      } else {
        print('Failed to save user data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error saving user data: $error');
    }
  }

  Future<void> updateweight({required int weight}) async {
    try {
      if (weight == null) {
        throw Exception('Please enter your weight!');
      }
      if (weight.isNegative) {
        print('Please enter weight as positive number!');
      }
      if (!isInteger(weight)) {
        print('Please enter weight as an integer number!');
      }

      final data = {'weight': weight.toString()};

      final response = await _request(data, update_weight_Api, 'POST');
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print('User data saved successfully');
      } else {
        print('Failed to save user data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error saving user data: $error');
    }
  }

  Future<void> updatesteps({required int steps}) async {
    try {
      if (steps == null) {
        throw Exception('Please enter your steps goal!');
      }
      if (steps.isNegative) {
        print('Please enter steps goal as positive number!');
      }
      if (!isInteger(steps)) {
        print('Please enter steps goal as an integer number!');
      }

      final data = {'steps': steps.toString()};

      final response = await _request(data, update_height_Api, 'POST');
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print('User data saved successfully');
      } else {
        print('Failed to save user data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error saving user data: $error');
    }
  }

  Future<void> updatecalories({required int calories}) async {
    try {
      if (calories == null) {
        throw Exception('Please enter your calories!');
      }
      if (calories.isNegative) {
        print('Please enter calories as positive number!');
      }
      if (!isInteger(calories)) {
        print('Please enter calories as an integer number!');
      }

      final data = {'calories': calories.toString()};

      final response = await _request(data, update_height_Api, 'POST');
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print('User data saved successfully');
      } else {
        print('Failed to save user data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error saving user data: $error');
    }
  }
}

// bool isInteger(num value) =>
//     (value % 1) ==
//     0; //if =0 it will return true (means stepsGoal is an integer)
bool isInteger(dynamic value) => value is int;

//Test:
void main() async {
  final userProgress = userMeasurment();

  // Example: Update gender
  await userProgress.updateGender(gender: 'male');

  // Example: Update height
  await userProgress.updateheight(height: 180);

  // Example: Update weight
  await userProgress.updateweight(weight: 70);

  // Example: Update steps
  await userProgress.updatesteps(steps: 10000);

  // Example: Update calories
  await userProgress.updatecalories(calories: 2000);
}
// void main() {
//   runApp(const MaterialApp(
//     home: Scaffold(
//       body: Center(
//         child: WelcomePage(),
//       ),
//     ),
//   ));
// }

const BASE_URL = 'https://samla.mohsowa.com/api';

Future<http.StreamedResponse> _request(
    Map<String, String> data, String endPoint, String method) async {
  var headers = {'Accept': 'application/json'};
  var request = http.MultipartRequest(method, Uri.parse(BASE_URL + endPoint));

  request.fields.addAll(data);

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  return response;
}
