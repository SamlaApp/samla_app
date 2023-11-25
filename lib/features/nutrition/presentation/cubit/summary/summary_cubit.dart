import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/nutrition/domain/entities/DailyNutritionPlanSummary.dart';
import 'package:samla_app/features/nutrition/domain/repositories/nutritionPlan_repository.dart';

part 'summary_state.dart';

class SummaryCubit extends Cubit<SummaryState> {
  SummaryCubit(this.repository) : super(SummaryInitial());
  final NutritionPlanRepository repository;

  @override
  Future<void> getDailyNutritionPlanSummary() async {
    emit(SummaryLoadingState()); // Show loading state
    final result = await repository.getDailyNutritionPlanSummary();
    result.fold(
        (failure) => emit(const SummaryErrorState(
            'Failed to get daily nutrition plan summary')),
        (dailyNutritionPlanSummary) {
      if (dailyNutritionPlanSummary == null) {
        emit(SummaryEmptyState());
        return;
      }
      emit(SummaryLoaded(dailyNutritionPlanSummary));
    });
  }

  @override
  Future<void> setCustomCalories(int calories) async {
    emit(SummaryLoadingState()); // Show loading state
    final result = await repository.setCustomCalories(calories: calories);
    result.fold(
        (failure) => emit(const SummaryErrorState(
            'Failed to set custom calories')),
        (dailyNutritionPlanSummary) {
      emit(CustomCaloriesAdded());
    });
  }
}
