import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/nutrition/domain/entities/NutritionPlanMeal.dart';
import 'package:samla_app/features/nutrition/domain/repositories/nutritionPlan_repository.dart';
part 'displayMeal_state.dart';

class DisplayMealCubit extends Cubit<DisplayMealState> {
  DisplayMealCubit(this.repository) : super(DisplayMealInitial());
  final NutritionPlanRepository repository;

  Future<void> getNutritionPlanMeals(String query, int id) async {
    emit(DisplayMealLoadingState()); // Show loading state
    final result = await repository.getNutritionPlanMeals(query: query, id: id);
    result.fold(
            (failure) => emit(const DisplayMealErrorState(
            'Failed to get nutrition plan meals')), (nutritionPlanMeal) {
      if (nutritionPlanMeal.isEmpty) {
        emit(DisplayMealEmptyState());
        return;
      }
      emit(DisplayMealLoaded(nutritionPlanMeal));
    });
  }


}


