import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:samla_app/features/auth/data/datasources/remote_data_source.dart';

Future<void> main(List<String> args) async {
  // json dummy object
  const paymentsJson = """
{
  "result": "success",
  "count": 2,
  "payments": [
    {
      "amount": "100.0",
      "destination": "rf1BiGeXwwQoi8",
      "executed_time": "2014-05-29T17:05:20Z",
      "source": "ra5nK24KXen9AH"
    },
    {
      "amount": "1.0",
      "destination": "ra5nK24KXen9AH",
      "executed_time": "2014-06-02T22:47:50Z",
      "source": "rf1BiGeXwwQoi8"
    }
  ]
}
""";
  Map<String, dynamic> payments = jsonDecode(paymentsJson);

  final http.Client client = http.Client();

  try {
    RemoteDataSourceImpl remoteDataSourceImpl =
        RemoteDataSourceImpl(client: client);
    // final user =
    //     await remoteDataSourceImpl.loginWithUsername('samla_user7', '12345678');
    final user2 = await remoteDataSourceImpl.signup(
      username: 'samla_user7',
      password: '12345678',
      name: 'Adel',
      email: 'test7@samla.com',
      phone: '010000000073',
      dateOfBirth: '1999-01-01',
    );
    print(user2.accessToken);
  } catch (e) {
    print(e);
  }
}
