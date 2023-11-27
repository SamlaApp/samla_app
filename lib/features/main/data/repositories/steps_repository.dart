import 'dart:convert';

import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/main/domain/entities/StepsLog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepsRepository {
  final SharedPreferences prefs;

  StepsRepository(this.prefs) {
    _loadCache();
  }

  List<StepsLog> cache = [];

  Future<StepsLog> addStepsLog(date, int sensor) async {
    // print('addStepsLog method: $sensor');
    StepsLog? stepsLog = searchCache(date);
    if (stepsLog == null) {
      // print('addStepsLog method is null');
      stepsLog = StepsLog(
        date: date,
        sensorRead: sensor,
        steps: 0,
      );
    } else {
      // print('addStepsLog method is not null');
      stepsLog = _update(stepsLog, sensor);
    }
    // print('addStepsLog method: prev read ${stepsLog.sensorRead}');
    stepsLog = await _updateInCache(stepsLog);
    return stepsLog;
  }

  StepsLog _update(StepsLog stepsLog, int sensor) {
    if (sensor >= stepsLog.sensorRead) {
      // print('update : steps will be added ${sensor - stepsLog.sensorRead}');
      return stepsLog.copyWith(
        steps: stepsLog.steps + (sensor - stepsLog.sensorRead),
        date: DateTime.now(),
        sensorRead: sensor,
      );
    } else {
      // print('update:steps will be added ${sensor}');

      return stepsLog.copyWith(
        date: DateTime.now(),
        sensorRead: sensor,
        steps: stepsLog.steps + sensor,
      );
    }
  }

  StepsLog? searchCache(DateTime date) {
    final filtered = cache.where((element) {
      return element.date.day == date.day &&
          element.date.month == date.month &&
          element.date.year == date.year;
    });
    if (filtered.isEmpty) {
      return null;
    }
    return filtered.first;
  }

  Future<StepsLog> _updateInCache(StepsLog stepsLog) async {
    final index = cache.indexWhere((element) {
      return element.date.day == stepsLog.date.day &&
          element.date.month == stepsLog.date.month &&
          element.date.year == stepsLog.date.year;
    });
    if (index == -1) {
      cache.add(stepsLog);
    } else {
      cache[index] = stepsLog;
    }
    await _saveCache();
    return stepsLog;
  }

  _loadCache() {
    final stringLogs = prefs.getString('stepsLogs');
    if (stringLogs != null) {
      final list = json.decode(stringLogs);
      print('cache list: ${list.length} logs');
      list.forEach((element) {
        final stepsLog = StepsLog.fromJson(element);
        print('cache: $element');
        cache.add(stepsLog);
      });
    }
  }

  _saveCache() async {
    final stringLogs = json.encode(cache);
    final result = await prefs.setString('stepsLogs', stringLogs);
    if (!result) {
      throw CacheFailure(message: 'Error saving cache');
    }
  }

  
}
