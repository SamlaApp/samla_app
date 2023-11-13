import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/nutrition/domain/entities/NutritionPlanMeal.dart';
import 'package:samla_app/features/nutrition/domain/entities/nutritionPlan.dart';
import 'package:samla_app/features/nutrition/domain/entities/MealLibrary.dart';




abstract class NutritionPlanRepository {
  Future<Either<Failure, List<NutritionPlan>>> getAllNutritionPlans();
  Future<Either<Failure, NutritionPlan>> createNutritionPlan({required NutritionPlan nutritionPlan});
  Future<Either<Failure, MealLibrary>> searchMealLibrary({required String query});
  Future<Either<Failure, MealLibrary>> addMealLibrary({required MealLibrary mealLibrary});
  Future<Either<Failure, NutritionPlanMeal>> addNutritionPlanMeal({required NutritionPlanMeal nutritionPlanMeal});
  Future<Either<Failure, List<NutritionPlanMeal>>> getNutritionPlanMeals({required String query});
}