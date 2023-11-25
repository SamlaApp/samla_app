import 'package:equatable/equatable.dart';

class StepsLog extends Equatable{
  final int steps;
  final DateTime date;
  final int sensorRead;

  StepsLog({required this.steps, required this.date, required this.sensorRead});

  factory StepsLog.fromJson(Map<String, dynamic> json) {
    return StepsLog(
      steps: json['steps'] is String ? int.parse(json['steps']) : json['steps'],
      date: DateTime.parse(json['date']),
      sensorRead: json['sensorRead'] is String ? int.parse(json['sensorRead']) : json['sensorRead'],
    );
  }

  
  // copywith
  StepsLog copyWith({int? steps, DateTime? date, int? sensorRead}) {
    return StepsLog(
      steps: steps ?? this.steps,
      date: date ?? this.date,
      sensorRead: sensorRead ?? this.sensorRead,
    );
  }

  Map<String, String> toJson() {
    return {
      'steps': steps.toString(),
      'date': date.toString(),
      'sensorRead': sensorRead.toString(),
    };
  }

  @override
  String toString() {
    return 'StepsLog(steps: $steps, date: ${date.day}/${date.month}/${date.year}, sensorRead: $sensorRead)';
  }

  @override
  List<Object?> get props => [steps, date, sensorRead];
}
