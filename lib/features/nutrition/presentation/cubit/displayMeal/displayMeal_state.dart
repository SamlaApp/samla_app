part of 'displayMeal_cubit.dart';

abstract class DisplayMealState extends Equatable {
  const DisplayMealState();

  @override
  List<Object> get props => [];
}

class DisplayMealInitial extends DisplayMealState {}

class DisplayMealLoadingState extends DisplayMealState {}

class DisplayMealLoaded extends DisplayMealState {
  final List<NutritionPlanMeal> nutritionPlanMeals;

  const DisplayMealLoaded(this.nutritionPlanMeals);

  @override
  List<Object> get props => [nutritionPlanMeals];
}

class DisplayMealErrorState extends DisplayMealState {
  final String message;

  const DisplayMealErrorState(this.message);
}

class DisplayMealEmptyState extends DisplayMealState {}