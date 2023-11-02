import 'package:http/http.dart' as http;
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/main.dart';

String BASE_URL = 'https://samla.mohsowa.com/api';
final client = sl.get<http.Client>();
final authBloc = sl.get<AuthBloc>();

Future<http.StreamedResponse> samlaAPI(
    {Map<String, String>? data,
    http.MultipartFile? file,
    required String endPoint,
    required String method,
    bool autoLogout = true}) async {
  try {
    final token = authBloc.user.accessToken;
    // final token = 'random'; // simulate unauthorized
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(method, Uri.parse(BASE_URL + endPoint));

    if (data != null) {
      request.fields.addAll(data);
    }

    if (file != null) {
      request.files.add(file);
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await client.send(request);
    if (response.statusCode == 401) {
      if (autoLogout) {
        authBloc.add(LogOutEvent(navigatorKey.currentState!.context));
      } else {
        throw UnauthorizedException();
      }
    }
    return response;
  } on Exception catch (e) {
    print(e.toString());
    throw ServerException(message: e.toString());
    // TODO
  }
}
