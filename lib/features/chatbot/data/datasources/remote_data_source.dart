import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:samla_app/core/error/exceptions.dart';

import '../../../profile/presentation/pages/PersonalInfo.dart';
import '../models/chatMessage_model.dart';

import 'package:samla_app/core/network/samlaAPI.dart';


const apiSecretKey = 'you should put your api key here';

Future<Map<String, dynamic>> getNutritionPlan() async {
  final res = await samlaAPI(endPoint: '/nutrition/plan/get_full', method: 'GET');
  final resBody = await res.stream.bytesToString();

  if (res.statusCode == 200) {
    // if empty return empty
    if(json.decode(resBody)['nutrition_plan'].length == 0){
      return {};
    }
    return json.decode(resBody)['nutrition_plan'];
  } else {
    return {};
    throw ServerException(message: json.decode(resBody)['message']);
  }
}
//progress/get_all
Future<Map<String, dynamic>> getProgress() async {
  final res = await samlaAPI(endPoint: '/progress/get_all', method: 'GET');
  final resBody = await res.stream.bytesToString();

  if (res.statusCode == 200) {
    // json.decode(resBody)['user_progress'];
    // if not empty
    if(json.decode(resBody)['user_progress'].length > 0){
      return json.decode(resBody)['user_progress'][0];
    }else{
      // return empty
      return {};
    }
  } else {
    return {};
    throw ServerException(message: json.decode(resBody)['message']);
  }
}

Future<Map<String, dynamic>> getNutritionSummary() async {
  final res = await samlaAPI(endPoint: '/nutrition/summary/total', method: 'GET');
  final resBody = await res.stream.bytesToString();

  print(resBody);

  if (res.statusCode == 200) {
    // if resBody is empty or only one element, add empty element
    if(json.decode(resBody)['nutrition_summary'].length == 0){
      return {
        "total_carbs": 0,
        "total_protein": 0,
        "total_fat": 0,
        "total_calories": 0
      };
    }else if(json.decode(resBody)['nutrition_summary'].length == 1){
      // add empty element at first
      return {
        "total_carbs": 0,
        "total_protein": 0,
        "total_fat": 0,
        "total_calories": 0,
        ...json.decode(resBody)['nutrition_summary'][0]
      };
    }else{
      return json.decode(resBody)['nutrition_summary'][0];
    }
  } else {
    return {
      "total_carbs": 0,
      "total_protein": 0,
      "total_fat": 0,
      "total_calories": 0
    };
    throw ServerException(message: json.decode(resBody)['message']);
  }
}
// /training/summary/get

Future<Map<String, dynamic>> getTrainingSummary() async {
  final res = await samlaAPI(endPoint: '/training/summary/get', method: 'GET');
  final resBody = await res.stream.bytesToString();
  if (res.statusCode == 200) {
    return json.decode(resBody)['summary'];
  } else {
    return {};
    throw ServerException(message: json.decode(resBody)['message']);
  }
}


Future<Map<String, dynamic>> getGoals() async {
  final res = await samlaAPI(endPoint: '/goals/get_goals', method: 'GET');
  final resBody = await res.stream.bytesToString();
  print(resBody);
  if (res.statusCode == 200) {
    return json.decode(resBody)['user_goals'];
  } else {
    return {};
    throw ServerException(message: json.decode(resBody)['message']);
  }
}


Future<String> generateResponse(String prompt,List<ChatMessage> _messages) async {
  const apiKey = apiSecretKey;



  var url = Uri.https("api.openai.com", "/v1/chat/completions");
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $apiKey"
    },

    body: json.encode({
      "model": "gpt-3.5-turbo-1106",
      "messages": [
        {
          "role": "system",
          "content": "You are helpful Samla's assistant you will help ${user.name}, start by saying hi to ${user.name}"
        },
        {
          "role": "system",
          "content": "Today is ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
        },
        {
          "role": "system",
          "content": "app name is Samla"
        },
        {
          "role": "system",
          "content": "You should give short answers"
        },
        {
          "role": "system",
          "content": "this is my goals data: as json string => ${await getGoals()}"
        },
        {
          "role": "system",
          "content": "this is my nutrition plan data: as json string => ${await getNutritionPlan()}"
        },
        {
          "role": "system",
          "content": "this is summary of taken food this week data: as json string => ${await getNutritionSummary()}"
        },
        {
          "role": "system",
          "content": "this is my progress data: as json string => ${await getProgress()}"
        },
        {
          "role": "system",
          "content": "this is my training summary data: as json string => ${await getTrainingSummary()}"
        },
        for(var i in _messages)
          {
            "role": i.chatMessageType == ChatMessageType.bot ? "system" : "user",
            "content": i.text
          },
        {
          "role": "user",
          "content": prompt
        }
      ],
      "temperature": 1,
      "max_tokens": 256,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0,
    }),
  );

  // Do something with the response
  Map<String, dynamic> newresponse = jsonDecode(response.body);

  return newresponse['choices'][0]['message']['content'];
}
