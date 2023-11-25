part of 'summary_cubit.dart';

sealed class SummaryState extends Equatable {
  const SummaryState();

  @override
  List<Object> get props => [];
}

class SummaryInitial extends SummaryState {}

class SummaryLoadingState extends SummaryState {}

class SummaryLoaded extends SummaryState {
  final DailyNutritionPlanSummary dailyNutritionPlanSummary;

  const SummaryLoaded(this.dailyNutritionPlanSummary);
}

class SummaryErrorState extends SummaryState {
  final String message;

  const SummaryErrorState(this.message);
}

class SummaryEmptyState extends SummaryState {}

class CustomCaloriesAdded extends SummaryState {}