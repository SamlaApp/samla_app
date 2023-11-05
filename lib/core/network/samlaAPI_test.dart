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
    final token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZmU5ZjRhMzk2MGQ1YmM0MjE4N2Y3NDllMzQ2N2ZiNWNmZWQ3NmU3MjdiMzU0Y2E1NDdhMDYxNmYxODBmY2U5MDg3YmUxNTk0ZjFiYzY4NTQiLCJpYXQiOjE2OTkxMjI3MDUuNjU2NzEyLCJuYmYiOjE2OTkxMjI3MDUuNjU2NzE3LCJleHAiOjE3MzA3NDUxMDUuNjIwMzc5LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.IdgJSsXJamO5cIh-y6E_OQdZXWxPZVAWoWVA-uzZJXvjHoZJsuVq0XV778pgYCFZHlGRq74EmY97lDnN2XasXzaYwAoxeVtFeYIFMZegymJw99qOaPjZaBqzLK4q6xE3Dbjwe5ixHCO-5C6Kmp4rvVORcuUOJtXb93y5CXY-3FA72YiBfGBGSReC0j3tHddaA2rINyOavMhzfo34CYkaVbS8Jd1VlIwd2l6Gasv3MVoKTqKpKtN0QdVL4XUi5mlr9AeV95uqfHx8BMngli6PF6L83DosauWSREIj7dWVDSEuw_X4XvC6wytmO7A646gZ2rQZse80VA7zA8XzjD575fKAWFHZcZkdQPi8h-3qqM_fRs2NmO0uxon9JRFYwD3VwIhsI6MQ2Gv4HSV07Mr1ixmt0QxXNVPzfDYBXpeWK7rIKtA2yqA7lfsOmsSscZqDVbtQntU2RJCyN9QWzhMzh81EaB5MiKyn9VCr6gkNg4LrixR3o0sZz08-NQFGsP9pGw8xfxTVwMYdVfyqA1OURQaYvzn77vQPtNzGyKzJlAgZmhFkcBl6Z2ezKiF9UnBROVrdJ0Ak01iUcKyt5OgiZqpGSZm1zlIxT1c-zFj6jglr681pB8PTInvtBemrFKiVqUUmy0YwINn8JLYUIGw8W8HRv3nrku5kfAJxxfleRdA';
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
