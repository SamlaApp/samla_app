import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/nutrition/domain/entities/nutritionPlan.dart';
import 'package:samla_app/features/nutrition/domain/repositories/nutritionPlan_repository.dart';


part 'nutritionPlan_state.dart';

class NutritionPlanCubit extends Cubit<NutritionPlanState> {
  NutritionPlanCubit(this.repository) : super(NutritionPlanInitial());
  final NutritionPlanRepository repository;

  // getAllNutritionPlans
  Future<void> getAllNutritionPlans() async {
    emit(NutritionPlanLoadingState()); // Show loading state
    final result = await repository.getAllNutritionPlans();
    result.fold((failure) => emit(NutritionPlanErrorState('Failed to fetch nutrition plans')),
        (nutritionPlans) {
      if (nutritionPlans.isEmpty) {
        print('empty');
        emit(NutritionPlanEmptyState());
        return;
      }
      emit(NutritionPlanLoaded(nutritionPlans.cast<NutritionPlan>()));
    });
  }

  // createNutritionPlan
  Future<void> createNutritionPlan(NutritionPlan nutritionPlan) async {
    emit(NutritionPlanLoadingState()); // Show loading state
    final result = await repository.createNutritionPlan(nutritionPlan: nutritionPlan);
    result.fold((failure) => emit(NutritionPlanErrorState('Failed to create nutrition plan')),
        (nutritionPlan) {
      if(nutritionPlan == null) {
        print('empty');
        emit(NutritionPlanEmptyState());
        return;
      }
      emit(NutritionPlanCreated(nutritionPlan));
    });
  }

}