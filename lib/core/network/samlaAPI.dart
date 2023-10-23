import 'package:http/http.dart' as http;
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/main.dart';

String BASE_URL = 'https://samla.mohsowa.com/api';
AuthBloc authBloc = sl<AuthBloc>();


Future<http.StreamedResponse> samlaRequest({bool isAuthRquired = true,  required method, required String endPoint, required Map<String, String> body}) async {
  String token = isAuthRquired ? authBloc.user.accessToken! : '';
  var headers = {'Accept': 'application/json',
        'Authorization': 'Bearer $token',
  };
  var request = http.MultipartRequest(method, Uri.parse(BASE_URL+endPoint));
  request.fields.addAll(body);

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 401) {
    authBloc.add(LogOutEvent(navigatorKey.currentState!.context));
  } else {
    return response;
  }
  return response;
}




