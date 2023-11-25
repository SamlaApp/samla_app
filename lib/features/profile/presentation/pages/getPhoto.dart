//
//step 2: api call to get the photo url
//save in the assest
//return the path of this photo

import 'package:flutter/material.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart'
    as authDI;
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:http/http.dart' as http;

Future<String> getPhotoUrl() async {
  final response = await http.get(Uri.parse('YOUR_API_ENDPOINT'));

  if (response.statusCode == 200) {
    // Parse the response JSON and extract the photo URL
    final photoUrl = parsePhotoUrl(response.body);
    return photoUrl;
  } else {
    throw Exception('Failed to load photo URL');
  }
}

String parsePhotoUrl(String responseBody) {
  // Implement your logic to parse the JSON and extract the photo URL
  // Replace this with your actual implementation
  return 'https://example.com/photo.jpg';
}
