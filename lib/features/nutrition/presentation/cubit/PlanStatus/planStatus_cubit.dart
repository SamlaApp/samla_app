import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/nutrition/domain/entities/NutritionPlanStatus.dart';
import 'package:samla_app/features/nutrition/domain/repositories/nutritionPlan_repository.dart';

part 'planStatus_state.dart';

class PlanStatusCubit extends Cubit<PlanStatusState> {
  PlanStatusCubit(this.repository) : super(PlanStatusInitial());
  final NutritionPlanRepository repository;

  Future<void> getNutritionPlanStatus(int id) async {
    emit(PlanStatusLoadingState()); // Show loading state
    final result = await repository.getNutritionPlanStatus(id: id);
    result.fold((failure) {
      print(failure.message);

      emit(const PlanStatusErrorState('Failed to fetch nutrition plan status'));
    }, (nutritionPlanStatus) {
      if (nutritionPlanStatus == null) {
        emit(PlanStatusEmptyState());
        return;
      }
      emit(PlanStatusLoaded(nutritionPlanStatus));
    });
  }

  //updateNutritionPlanStatus
  Future<void> updateNutritionPlanStatus(
      NutritionPlanStatus nutritionPlanStatus) async {
    emit(PlanStatusLoadingState()); // Show loading state
    final result = await repository.updateNutritionPlanStatus(
        nutritionPlanStatus: nutritionPlanStatus);
    result.fold(
        (failure) => emit(const PlanStatusErrorState(
            'Failed to update nutrition plan status')), (nutritionPlanStatus) {
      if (nutritionPlanStatus == null) {
        emit(PlanStatusEmptyState());
        return;
      }
      emit(PlanStatusLoaded(nutritionPlanStatus));
    });
  }
}
