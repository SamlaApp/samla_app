import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Progress extends Equatable {
  final int? id;
  final double? weight;
  final double? height;
  final int? steps;
  final int? calories;
  final DateTime? date;

  const Progress({
    this.id,
    required this.weight,
    required this.height,
    required this.steps,
    required this.calories,
    required this.date,
  });

  @override
  List<Object?> get props => [id, weight, height, steps, calories, date];
  //copyWith
  Progress copyWith({
    int? id,
    double? weight,
    double? height,
    int? steps,
    int? calories,
    DateTime? date,
  }) {
    return Progress(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      steps: steps ?? this.steps,
      calories: calories ?? this.calories,
      date: date ?? this.date,
    );
  }

}

