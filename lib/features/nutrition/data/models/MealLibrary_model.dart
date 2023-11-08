import '../../domain/entities/MealLibrary.dart';

class MealLibraryModel extends MealLibrary {
  const MealLibraryModel({
    required super.id,
    required super.name,
    required super.calories,
    required super.fat,
    required super.protein,
    required super.carbs,
    required super.serving_size_g,
  });

  @override
  factory MealLibraryModel.fromJson(Map<String, dynamic> json) {
    return MealLibraryModel(
      id: json['id'],
      name: json['name'],
      calories: json['calories'],
      fat: json['fat'],
      protein: json['protein'],
      carbs: json['carbs'],
      serving_size_g: json['serving_size_g']?.toDouble(),
    );
  }

  Map<String, String> toJson() {
    return {
      'id': id.toString(),
      'name': name,
      'calories': calories.toString(),
      'fat': fat.toString(),
      'protein': protein.toString(),
      'carbs': carbs.toString(),
      'serving_size_g': serving_size_g.toString(),
    };
  }

  factory MealLibraryModel.fromEntity(MealLibrary entity) {
    return MealLibraryModel(
      id: entity.id,
      name: entity.name,
      calories: entity.calories,
      fat: entity.fat,
      protein: entity.protein,
      carbs: entity.carbs,
      serving_size_g: entity.serving_size_g,
    );
  }
}
