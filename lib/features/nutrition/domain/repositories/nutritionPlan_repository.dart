import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/nutrition/domain/entities/nutritionPlan.dart';

abstract class NutritionPlanRepository {
  Future<Either<Failure, List<NutritionPlan>>> getAllNutritionPlans();
  Future<Either<Failure, NutritionPlan>> createNutritionPlan({required NutritionPlan nutritionPlan});
}