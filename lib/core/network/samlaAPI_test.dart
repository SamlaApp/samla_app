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
    final token =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMGFhN2NhNWRiZmVjZGUxYmE0YzJmODNiOGE1ZmY3M2Y2MTY3MjM5MzIxMGM4MDA2OTQ5MmI4MDIyYWQzNTRjMzliNWM3MTJjYzkzZWY1NTAiLCJpYXQiOjE2OTkyMDE3MzEuNDE2MTYyLCJuYmYiOjE2OTkyMDE3MzEuNDE2MTY2LCJleHAiOjE3MzA4MjQxMzEuNDA3MzUsInN1YiI6IjIiLCJzY29wZXMiOltdfQ.uZoXlBEPzx3x7zV99XudL0PmJXyB9HVsubr1PyU8ON1AOW3h_im2dEx7JkEOn0x6DY1pUNuquCgow1ZkFszLbAgr86qc9UuISlzL-xegVK_5JRGuQ-wipO3qdTdWXst0HHvQQ6zSH9V1T4f4RvdUswigV2LDBA7ESYu5GQQ0BN9-qkjJmtXDFUP4u15hKZFrzTkWBzmtT9rnaKPB5z2gi83kdp2MT5P9G2eMTTBnjUFuLGdQ_l4tVZ481WQOYWeJ7kwG3E7AsuHzNn4-_BPVFb34ur1PkPjrnmpJxc0lVfpwsSjzKIDXsqWr6wIFr6_I5wfdsG6LYAMXf4DQUmFyE1RhTzy-J63DovBCmmL9TGqBbh6mVermHimbyFXnNJV9rkygfcNtALDHCJA1FHViuDkicxh6MKPywxUkm4WdAm4o88RETlbFkhC4_qHTcnOoBrD_rrfDW6rGTDevttswymxy_AC8F5U9O-9EQkYlkjwQ7_dRJfpexGwI9P_GSPWYx3ei9Tn7S0Kn548OhYX3ep-_JYPUXzYqBLikiPlJl-5N1en-mplXU93nWZS_0Rjiq_PchV32oFyPd3ZzPWX0t01AFFGNfHuvE-KKlmvzCQsF4uBV4cAox49xwj0eLV1Seyu0UQjkmg8ORMKzHsPnf3yLvyBmGsP1abVE9o11MNE';
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
