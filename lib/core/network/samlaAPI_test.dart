import 'package:http/http.dart' as http;
import 'package:samla_app/core/error/exceptions.dart';

String BASE_URL = 'https://samla.mohsowa.com/api';

final client = http.Client();
Future<http.StreamedResponse> samlaAPItest(
    {Map<String, String>? data,
    http.MultipartFile? file,
    required String endPoint,
    required String method,
    bool autoLogout = true}) async {
  try {
    final token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWI0ODhiN2M5NjIzZWZlMDMyOTVmMDM1NTE1NmMwMjJhMzU1OGM0YmU3NjgzZDUwODY2NjZmNjYwZmQ1ZTkxNWNhZTc1NWJlNWExMWU2YjYiLCJpYXQiOjE3MDIwNDYwMDkuMDYwMTE1LCJuYmYiOjE3MDIwNDYwMDkuMDYwMTE4LCJleHAiOjE3MzM2Njg0MDkuMDUyNjU3LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.iSYKHPZz8Z9bXI_ZpGFBu4y0x1CYH07Sg1GopYdq47tmc2PhVTgzNZDJG5Dk9YsLOcQL64OBrqeM4RXnxNwI56kbxkDer0Vs11UwZGqE41j80f7ol2urDmZ7Pg2s19XNrqYuV9FH3A-P-ardw3qhvuv5Mmsc3ILqGiglXRn2NkEgTStBhL_7kCpAlxkwwOYnl8csJNCdMHvd9yF66DmI76HN1MbgSewMBH6O_4rhnSx-4ULI_xH4QdulayGoQbcMTpwS20RqgjAWR1fm-ozp-CDyTlPrONksycKIg6P3oO4Bu_7l34otjyj46dU5gMf6VhhFdywfnu3e9eD6p0H-R8RoefDnWUg18vboXNOuQ9MYBxp5bA5PwpGTfAJe3LSwiy0txhjPEVVCbZYGoVCvUXd7i39zWKCMIt8sqIgk-iJfTT0jlDnNaDVjXH1mNqXSu2sqKnkFsHpoCrQcNjptqF5AIQEQfFNt-o10u3kHrcSbv8n7VdEevsc-DCQQg9qRqim_7O40-6v50pCqXNZOUe8Fb6Xno5tS4h9NUfVdcbIUWhI3cupP99Y0HLzUh46iVQoXDhdF8xGHKsIv1BQFUljHg9F4mcfnZ2gqYNVaWnL32fEX6kHM3Li_dBSw69jEC-t1wR3orjdGUVFE1Onuj7MtC9StYbOF2YhWPQCK7AY';
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
        // not available in test mode
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
