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

  const NutritionPlanCreatedSuccessfullyState(this.nutritionPlan);
}

final class NutritionPlanErrorState extends NutritionPlanState {
  final String message;

  const NutritionPlanErrorState(this.message);
}

final class NutritionPlanEmptyState extends NutritionPlanState {}

final class NutritionPlanLoaded extends NutritionPlanState {
  final List<NutritionPlan> nutritionPlans;
  final List<MealLibrary> meals;
  const NutritionPlanLoaded(this.nutritionPlans, this.meals);
}

final class NutritionPlanCreated extends NutritionPlanState {
  final NutritionPlan nutritionPlan;

  const NutritionPlanCreated(this.nutritionPlan);
}

final class NutritionPlanMealLibraryLoaded extends NutritionPlanState {
  final MealLibrary mealLibrary;

  const NutritionPlanMealLibraryLoaded(this.mealLibrary);
}

final class NutritionPlanMealRemoved extends NutritionPlanState {
  final List<MealLibrary> updatedMeals;

  const NutritionPlanMealRemoved(this.updatedMeals);
}

final class NutritionPlanMealLibraryAdded extends NutritionPlanState {
  final MealLibrary updatedMeals;

  const NutritionPlanMealLibraryAdded(this.updatedMeals);
}

final class NutritionPlanMealAdded extends NutritionPlanState {
  final NutritionPlanMeal nutritionPlanMeal;

  const NutritionPlanMealAdded(this.nutritionPlanMeal);
}

final class NutritionPlanMealRemovedSuccessfully extends NutritionPlanState {
  final NutritionPlanMeal nutritionPlanMeal;

  const NutritionPlanMealRemovedSuccessfully(this.nutritionPlanMeal);
}

final class NutritionPlanMealUpdated extends NutritionPlanState {
  final NutritionPlanMeal nutritionPlanMeal;

  const NutritionPlanMealUpdated(this.nutritionPlanMeal);
}

// NutritionPlanMealEmptyState
final class NutritionPlanMealEmptyState extends NutritionPlanState {}

// NutritionPlanMealErrorState
final class NutritionPlanMealErrorState extends NutritionPlanState {
  final String message;

  const NutritionPlanMealErrorState(this.message);
}

// NutritionPlanMealLoaded
final class NutritionPlanMealLoaded extends NutritionPlanState {
  final List<NutritionPlanMeal> nutritionPlanMeals;

  const NutritionPlanMealLoaded(this.nutritionPlanMeals);
}

// NutritionPlanMealsLoadingState
final class NutritionPlanMealsLoadingState extends NutritionPlanState {}

// NutritionPlanMealDeleted
final class NutritionPlanMealDeleted extends NutritionPlanState {
  final NutritionPlanMeal nutritionPlanMeal;

  const NutritionPlanMealDeleted(this.nutritionPlanMeal);
}

//NutritionPlanDeleted
final class NutritionPlanDeleted extends NutritionPlanState {
  final NutritionPlan nutritionPlan;

  const NutritionPlanDeleted(this.nutritionPlan);
}

//NutritionPlanStatusLoaded
final class NutritionPlanStatusLoaded extends NutritionPlanState {
  final NutritionPlanStatus nutritionPlanStatus;

  const NutritionPlanStatusLoaded(this.nutritionPlanStatus);
}

// NutritionPlanDailySummaryLoaded
final class NutritionPlanDailySummaryLoaded extends NutritionPlanState {
  final DailyNutritionPlanSummary dailyNutritionPlanSummary;

  const NutritionPlanDailySummaryLoaded(this.dailyNutritionPlanSummary);
}