import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/nutrition/domain/entities/DailyNutritionPlanSummary.dart';
import 'package:samla_app/features/nutrition/domain/entities/MealLibrary.dart';
import 'package:samla_app/features/nutrition/domain/entities/NutritionPlanMeal.dart';
import 'package:samla_app/features/nutrition/domain/entities/NutritionPlanStatus.dart';
import 'package:samla_app/features/nutrition/domain/entities/nutritionPlan.dart';
import 'package:samla_app/features/nutrition/domain/repositories/nutritionPlan_repository.dart';
part 'nutritionPlan_state.dart';

class NutritionPlanCubit extends Cubit<NutritionPlanState> {
  NutritionPlanCubit(this.repository) : super(NutritionPlanInitial());
  final NutritionPlanRepository repository;

  @override
  Future<void> close() async {
    print('someone tried to close the nutrition plan cubit');
  }

  // getAllNutritionPlans
  Future<void> getAllNutritionPlans() async {
    emit(NutritionPlanLoadingState()); // Show loading state
    final result = await repository.getAllNutritionPlans();
    result.fold(
        (failure) => emit(
            const NutritionPlanErrorState('Failed to fetch nutrition plans')),
        (nutritionPlans) {
      if (nutritionPlans.isEmpty) {
        print('empty');
        emit(NutritionPlanEmptyState());
        return;
      }
      emit(NutritionPlanLoaded(nutritionPlans.cast<NutritionPlan>(), []));
    });
  }

  Future<void> createNutritionPlan(NutritionPlan nutritionPlan) async {
    emit(NutritionPlanLoadingState()); // Show loading state
    final result =
        await repository.createNutritionPlan(nutritionPlan: nutritionPlan);
    result.fold((failure) {
      emit(NutritionPlanErrorState(failure.message));
    }, (nutritionPlan) {
      if (nutritionPlan == null) {
        print('empty');
        emit(NutritionPlanEmptyState());
      }
      emit(NutritionPlanCreated(nutritionPlan));
    });
  }

  Future<void> searchMealLibrary(String query) async {
    emit(NutritionPlanLoadingState()); // Show loading state
    final result = await repository.searchMealLibrary(query: query);
    result.fold(
        (failure) => emit(
            const NutritionPlanErrorState('Failed to search meal library')),
        (mealLibrary) {
      if (mealLibrary == null) {
        print('empty');
        emit(NutritionPlanEmptyState());
        return;
      }
      emit(NutritionPlanMealLibraryLoaded(mealLibrary));
    });
  }

  Future<void> addMealLibrary(MealLibrary mealLibrary) async {
    emit(NutritionPlanLoadingState()); // Show loading state
    final result = await repository.addMealLibrary(mealLibrary: mealLibrary);
    result.fold(
        (failure) =>
            emit(const NutritionPlanErrorState('Failed to add meal library')),
        (mealLibrary) {
      if (mealLibrary == null) {
        print('empty');
        emit(NutritionPlanEmptyState());
        return;
      }
      emit(NutritionPlanMealLibraryAdded(mealLibrary));
    });
  }

  //addNutritionPlanMeal
  Future<void> addNutritionPlanMeal(NutritionPlanMeal nutritionPlanMeal) async {
    emit(NutritionPlanLoadingState()); // Show loading state
    final result = await repository.addNutritionPlanMeal(
        nutritionPlanMeal: nutritionPlanMeal);
    result.fold(
        (failure) => emit(const NutritionPlanMealErrorState(
            'Failed to add nutrition plan meal')), (nutritionPlanMeal) {
      if (nutritionPlanMeal == null) {
        emit(NutritionPlanMealEmptyState());
        return;
      }
      emit(NutritionPlanMealAdded(nutritionPlanMeal));
    });
  }

  //deleteNutritionPlanMeal
  Future<void> deleteNutritionPlanMeal(int id) async {
    emit(NutritionPlanLoadingState()); // Show loading state
    final result = await repository.deleteNutritionPlanMeal(id: id);
    result.fold(
        (failure) => emit(const NutritionPlanMealErrorState(
            'Failed to delete nutrition plan meal')), (nutritionPlanMeal) {
      if (nutritionPlanMeal == null) {
        emit(NutritionPlanMealEmptyState());
        return;
      }
      emit(NutritionPlanMealDeleted());
    });
  }

  // getNutritionPlanMeals
  Future<void> getNutritionPlanMeals(String query, int id) async {
    emit(NutritionPlanMealsLoadingState()); // Show loading state
    final result = await repository.getNutritionPlanMeals(query: query, id: id);
    result.fold(
        (failure) => emit(const NutritionPlanMealErrorState(
            'Failed to get nutrition plan meals')), (nutritionPlanMeal) {
      if (nutritionPlanMeal.isEmpty) {
        emit(NutritionPlanMealEmptyState());
        return;
      }
      emit(NutritionPlanMealLoaded(nutritionPlanMeal));
    });
  }

  // deleteNutritionPlan
  Future<void> deleteNutritionPlan(int id) async {
    emit(NutritionPlanLoadingState()); // Show loading state
    final result = await repository.deleteNutritionPlan(id: id);
    result.fold(
        (failure) => emit(
            const NutritionPlanErrorState('Failed to delete nutrition plan')),
        (nutritionPlan) {
      if (nutritionPlan == null) {
        emit(NutritionPlanEmptyState());
        return;
      }
      emit(NutritionPlanDeleted());
    });
  }
}
