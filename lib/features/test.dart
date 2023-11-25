import 'dart:convert';

import 'package:samla_app/features/main/domain/entities/StepsLog.dart';

void main(List<String> args) {
  List<StepsLog> cache = [];

  StepsLog s2 = StepsLog(
    steps: 0,
    date: DateTime.now(),
    sensorRead: 0,
  );

  StepsLog s1 = StepsLog(
    steps: 0,
    date: DateTime.now().subtract(Duration(days: 1)),
    sensorRead: 0,
  );

  cache.add(s1);
  cache.add(s2);

  // encode json
  final encodedJson = json.encode(cache);
  print(encodedJson);

  // decode json
  cache = _loadCache(encodedJson);

  // find the log with same day 
  final filtered = cache.where((element) {
    return element.date.day == DateTime.now().day &&
        element.date.month == DateTime.now().month &&
        element.date.year == DateTime.now().year;
  });
  if (filtered.isEmpty) {
    print('not found');
  } else {
    print('found');
    print(filtered.first.date);
  }
}

List<StepsLog> _loadCache(encoded) {
   final stringLogs = encoded;
   List<StepsLog> cache = [];
  if (stringLogs != null) {
    final list = json.decode(stringLogs);
    list.forEach((element) {
      final stepsLog = StepsLog.fromJson(element);
      cache.add(stepsLog);
    });
  }
  return cache;
}
