part of 'nutritionPlan_cubit.dart';

sealed class NutritionPlanState extends Equatable {
  const NutritionPlanState();

  @override
  List<Object> get props => [];
}

final class NutritionPlanInitial extends NutritionPlanState {}

final class NutritionPlanLoadingState extends NutritionPlanState {}

final class NutritionPlanCreatedSuccessfullyState extends NutritionPlanState {
  final NutritionPlan nutritionPlan;

  NutritionPlanCreatedSuccessfullyState(this.nutritionPlan);
}

final class NutritionPlanErrorState extends NutritionPlanState {
  final String message;

  NutritionPlanErrorState(this.message);
}

final class NutritionPlanEmptyState extends NutritionPlanState {}

final class NutritionPlanLoaded extends NutritionPlanState {
  final List<NutritionPlan> nutritionPlans;
  final List<MealLibrary> meals;
  NutritionPlanLoaded(this.nutritionPlans, this.meals);
}

final class NutritionPlanCreated extends NutritionPlanState {
  final NutritionPlan nutritionPlan;

  NutritionPlanCreated(this.nutritionPlan);
}

final class NutritionPlanMealLibraryLoaded extends NutritionPlanState {
  final MealLibrary mealLibrary;

  NutritionPlanMealLibraryLoaded(this.mealLibrary);
}

final class NutritionPlanMealAdded extends NutritionPlanState {
  final List<MealLibrary> updatedMeals;

  NutritionPlanMealAdded(this.updatedMeals);
}

final class NutritionPlanMealRemoved extends NutritionPlanState {
  final List<MealLibrary> updatedMeals;

  NutritionPlanMealRemoved(this.updatedMeals);
}
