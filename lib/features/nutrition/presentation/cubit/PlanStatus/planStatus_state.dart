part of 'planStatus_cubit.dart';

abstract class PlanStatusState extends Equatable {
  const PlanStatusState();

  @override
  List<Object> get props => [];
}

class PlanStatusInitial extends PlanStatusState {}

class PlanStatusLoadingState extends PlanStatusState {}

class PlanStatusLoaded extends PlanStatusState {
  final NutritionPlanStatus nutritionPlanStatus;

  PlanStatusLoaded(this.nutritionPlanStatus);

  @override
  List<Object> get props => [nutritionPlanStatus];
}

class PlanStatusErrorState extends PlanStatusState {
  final String message;

  const PlanStatusErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class PlanStatusEmptyState extends PlanStatusState {}