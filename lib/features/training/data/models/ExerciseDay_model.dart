import 'package:samla_app/features/training/domain/entities/ExerciseDay.dart';

class ExerciseDayModel extends ExerciseDay{
  const ExerciseDayModel({
    required super.id,
    required super.sunday,
    required super.monday,
    required super.tuesday,
    required super.wednesday,
    required super.thursday,
    required super.friday,
    required super.saturday,
    required super.exercise_template_id,
    required super.exercise_library_id,
  });

  @override
  factory ExerciseDayModel.fromJson(Map<String, dynamic> json) {
    return ExerciseDayModel(
      id: json['id'],
      sunday: json['sunday']  == 1 ? true : false,
      monday: json['monday']  == 1 ? true : false,
      tuesday: json['tuesday']  == 1 ? true : false,
      wednesday: json['wednesday']  == 1 ? true : false,
      thursday: json['thursday']  == 1 ? true : false,
      friday: json['friday']  == 1 ? true : false,
      saturday: json['saturday']  == 1 ? true : false,
      exercise_template_id: int.parse(json['exercise_template_id']),
      exercise_library_id: int.parse(json['exercise_library_id']),
    );
  }


  factory ExerciseDayModel.fromEntity(ExerciseDay entity) {
    return ExerciseDayModel(
      id: entity.id,
      sunday: entity.sunday,
      monday: entity.monday,
      tuesday: entity.tuesday,
      wednesday: entity.wednesday,
      thursday: entity.thursday,
      friday: entity.friday,
      saturday: entity.saturday,
      exercise_template_id: entity.exercise_template_id,
      exercise_library_id: entity.exercise_library_id,
    );
  }

  Map<String, String> toJson() {
    return {
      'id': int.parse(id.toString()).toString(),
      'sunday': sunday? '1' : '0',
      'monday': monday? '1' : '0',
      'tuesday': tuesday? '1' : '0',
      'wednesday': wednesday? '1' : '0',
      'thursday': thursday? '1' : '0',
      'friday': friday? '1' : '0',
      'saturday': saturday? '1' : '0',
      'exercise_template_id': exercise_template_id.toString(),
      'exercise_library_id': exercise_library_id.toString(),
    };
  }

ExerciseDayModel copyWith({
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
    return ExerciseDayModel(
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