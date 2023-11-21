part of 'todayPlan_cubit.dart';


abstract class TodayPlanState extends Equatable {
  const TodayPlanState();

  @override
  List<Object> get props => [];
}

class TodayPlanInitial extends TodayPlanState {}

class TodayPlanLoadingState extends TodayPlanState {}

class TodayPlanLoaded extends TodayPlanState {
  final List<NutritionPlan> nutritionPlans;

  const TodayPlanLoaded(this.nutritionPlans);

  @override
  List<Object> get props => [nutritionPlans];
}

class TodayPlanErrorState extends TodayPlanState {
  final String message;

  const TodayPlanErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class TodayPlanEmptyState extends TodayPlanState {}
