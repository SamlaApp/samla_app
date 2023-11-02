import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:samla_app/features/auth/auth_injection_container.dart'
as authDI;

import '../../../profile/presentation/pages/PersonalInfo.dart';
import '../models/chatMessage_model.dart';

const apiSecretKey = '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';

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
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content": "You are helpful Samla's assistant you will help ${user.name}, start by saying hi to him"
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
