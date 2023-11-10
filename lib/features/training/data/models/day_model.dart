import 'exercise_model.dart';

class DayModel {
  final String dayId;
  final String dayName;
  final List<ExerciseModel> exercises;

  DayModel({
    required this.dayId,
    required this.dayName,
    required this.exercises,
  });

  factory DayModel.fromJson(Map<String, dynamic> json) {
    return DayModel(
      dayId: json['dayId'],
      dayName: json['dayName'],
      exercises: List<ExerciseModel>.from(json['exercises'].map((x) => ExerciseModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayId': dayId,
      'dayName': dayName,
      'exercises': exercises.map((x) => x.toJson()).toList(),
    };
  }
}
