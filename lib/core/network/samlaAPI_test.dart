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
    final token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYTJhYWQ2MjUxNTMwNDM1YjI5MGIxYjA5ODI4NDY5ZjUzMDA5YzM2YWI0NTQ4ODUzMTIxZDFjNzllY2JhZmJkMzkwYWY3ZmQ1NzdiYjhiZGIiLCJpYXQiOjE2OTkxNTU4NDIuMTY3NTgsIm5iZiI6MTY5OTE1NTg0Mi4xNjc1ODYsImV4cCI6MTczMDc3ODI0Mi4xNTk1OTEsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.t5eteZG0PDpe9YkqonHk7MM05YshykA9Vd752p7RI-rZgZo3N3mdKdAYLhcOSqQRmDkG7ZpgJddUTOjVtjLgcKzlJHWwqgK15aIPUlUfZjpYFn1rNwfLCP2ulcDl3I2qViimuvz2ccTz-Hzesx0eD-vCcv99_iqA1vydPccqcTmQBOd3jLDvXbbVRYJyEGyGnB5YTIGTaEgybp2b8LecIMxTPgz1g5MsM9ABA6-gygixV5pMM64-o0ZF-hGVB7_b--JsCzZ55Edy6gMl5tyuL1_FCoGCoiKhuBYNWtt1WSdinZbh6Eg5aesHnpe5-BJBzbmNthUryfM4BnMPV9nYQxh4mPg7DkRaZcrjzeQvCfdkk7fGvOcLOWipjKQc25FfsMaDDurpjEcqnRyoF3Y0DfI-Kn9IZdcMWg2B-KNjfeti0ZXyDTXs97n2jR8yvovJCUQskgqPq1ur5or0e6m0Hve8e4ZeoUgPsbpLZ7NHN4VPE7e6H-VtHw6c2GmKWljtVqlzv3SgQ4lp2NckSsKrUm0tyX_8RiDkFiDeSnaYeHk-sBIJ75I8-CNfDanekMO_ujIeD_MA0tLPZpo1GQzInQ_qfZ6Y2FJaiaeoC7hiAbriRxI8oalZSekWpaH3VQgSLMCIH7LTcd3kDmfuWkEKP22EjDcG9aLzNja4FM6gMcs'; // final token = 'random'; // simulate unauthorized
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
