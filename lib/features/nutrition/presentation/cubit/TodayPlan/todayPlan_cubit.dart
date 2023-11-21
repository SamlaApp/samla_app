import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/nutrition/domain/entities/MealLibrary.dart';
import 'package:samla_app/features/nutrition/domain/repositories/nutritionPlan_repository.dart';
import 'package:samla_app/features/nutrition/domain/entities/nutritionPlan.dart';


part 'todayPlan_state.dart';

class TodayPlanCubit extends Cubit<TodayPlanState> {
  TodayPlanCubit(this.repository) : super(TodayPlanInitial());
  final NutritionPlanRepository repository;

  Future<void> getTodayNutritionPlan(String query) async {
    emit(TodayPlanLoadingState()); // Show loading state
    final result = await repository.getTodayNutritionPlan(query: query);
    result.fold(
        (failure) => emit(
            const TodayPlanErrorState('Failed to get today nutrition plan')),
        (nutritionPlan) {
      if (nutritionPlan == null) {
        print('empty');
        emit(TodayPlanEmptyState());
      }
      emit(TodayPlanLoaded(nutritionPlan.cast<NutritionPlan>()));
    });
  }
}
