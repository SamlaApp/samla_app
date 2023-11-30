import 'dart:convert';

import 'package:intl/intl.dart';

class Progress {
  final DateTime date;

  // Other attributes of the Progress class

  Progress(this.date);
  @override
  String toString() {
    // TODO: implement toString
    return 'date: $date';
  }
}

Map<String, num> getLast7DaysProgress(List<Progress> progressList) {
  final Map<String, num> last7DaysProgressMap = {};

  // Get the current date
  final currentDate = DateTime.now();

  // Iterate over the last 7 days
  for (var i = 0; i < 7; i++) {
    // Calculate the date for the current iteration
    final date = currentDate.subtract(Duration(days: i));

    // Format the date to a day name (e.g., "Monday", "Tuesday")
    final dayName = DateFormat('EEEE').format(date);

    // Find progress for the current date
    var progressForDate = progressList.where((progress) {
      return progress.date.year == date.year &&
          progress.date.month == date.month &&
          progress.date.day == date.day;
    });

    // Store the progress for the day in the map
    if (progressForDate.isNotEmpty) {
      // last7DaysProgressMap[dayName] = progressForDate.first.steps;
    } else {
      last7DaysProgressMap[dayName] = 0;
    }
  }

  return last7DaysProgressMap;
}

void main() {
  // Example usage
  final progressList = [
    Progress(DateTime.now().subtract(Duration(days: 1))),
    // Add more Progress objects with different dates
    Progress(DateTime.now().subtract(Duration(days: 2))),
    Progress(DateTime.now().subtract(Duration(days: 6))),
    Progress(DateTime.now().subtract(Duration(days: 21))),
  ];

  final result = getLast7DaysProgress(progressList);
  print(result);
}
