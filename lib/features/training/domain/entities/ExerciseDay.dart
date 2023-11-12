import 'package:equatable/equatable.dart';

class ExerciseDay extends Equatable {
  final int? id;
  final bool sunday;
  final bool monday;
  final bool tuesday;
  final bool wednesday;
  final bool thursday;
  final bool friday;
  final bool saturday;
  final int exercise_template_id;
  final int exercise_library_id;

  const ExerciseDay({
    this.id,
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.exercise_template_id,
    required this.exercise_library_id,
  });

  @override
  List<Object?> get props => [id, sunday, monday, tuesday, wednesday, thursday, friday, saturday, exercise_template_id, exercise_library_id];

  ExerciseDay copyWith({
    int? id,
    bool? sunday,
    bool? monday,
    bool? tuesday,
    bool? wednesday,
    bool? thursday,
    bool? friday,
    bool? saturday,
    int? exercise_template_id,
    int? exercise_library_id,
  }) {
    return ExerciseDay(
      id: id ?? this.id,
      sunday: sunday ?? this.sunday,
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
      exercise_template_id: exercise_template_id ?? this.exercise_template_id,
      exercise_library_id: exercise_library_id ?? this.exercise_library_id,
    );
  }

}