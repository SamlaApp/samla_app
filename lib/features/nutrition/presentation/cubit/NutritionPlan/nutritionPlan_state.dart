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

final class NutritionPlanMealRemoved extends NutritionPlanState {
  final List<MealLibrary> updatedMeals;

  NutritionPlanMealRemoved(this.updatedMeals);
}

final class NutritionPlanMealLibraryAdded extends NutritionPlanState {
  final MealLibrary updatedMeals;

  NutritionPlanMealLibraryAdded(this.updatedMeals);
}

final class NutritionPlanMealAdded extends NutritionPlanState {
  final NutritionPlanMeal nutritionPlanMeal;

  NutritionPlanMealAdded(this.nutritionPlanMeal);
}

final class NutritionPlanMealRemovedSuccessfully extends NutritionPlanState {
  final NutritionPlanMeal nutritionPlanMeal;

  NutritionPlanMealRemovedSuccessfully(this.nutritionPlanMeal);
}

final class NutritionPlanMealUpdated extends NutritionPlanState {
  final NutritionPlanMeal nutritionPlanMeal;

  NutritionPlanMealUpdated(this.nutritionPlanMeal);
}

// NutritionPlanMealEmptyState
final class NutritionPlanMealEmptyState extends NutritionPlanState {}

// NutritionPlanMealErrorState
final class NutritionPlanMealErrorState extends NutritionPlanState {
  final String message;

  NutritionPlanMealErrorState(this.message);
}

// NutritionPlanMealLoaded
final class NutritionPlanMealLoaded extends NutritionPlanState {
  final List<NutritionPlanMeal> nutritionPlanMeals;

  NutritionPlanMealLoaded(this.nutritionPlanMeals);
}

// NutritionPlanMealsLoadingState
final class NutritionPlanMealsLoadingState extends NutritionPlanState {}