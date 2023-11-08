import 'package:equatable/equatable.dart';

class MealLibrary extends Equatable {
  final int? id;
  final String name;
  final int calories;
  final double fat;
  final double protein;
  final double carbs;
  final double serving_size_g;

  const MealLibrary({
    this.id,
    required this.name,
    required this.calories,
    required this.fat,
    required this.protein,
    required this.carbs,
    required this.serving_size_g,
  });

  @override
  List<Object?> get props => [id, name, calories, fat, protein, carbs, serving_size_g];


  MealLibrary copyWith({
    int? id,
    String? name,
    int? calories,
    double? fat,
    double? protein,
    double? carbs,
    double? serving_size_g,
  }) {
    return MealLibrary(
      id: id ?? this.id,
      name: name ?? this.name,
      calories: calories ?? this.calories,
      fat: fat ?? this.fat,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      serving_size_g: serving_size_g ?? this.serving_size_g,
    );
  }

}

