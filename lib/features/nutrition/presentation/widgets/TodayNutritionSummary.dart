import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/nutrition/nutrition_di.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/nutritionPlan_cubit.dart';
import 'package:samla_app/features/nutrition/presentation/widgets/MaelAdapt/NutrientColumn.dart';

class TodayNutritionSummary extends StatefulWidget {
  const TodayNutritionSummary({Key? key}) : super(key: key);

  @override
  _TodayNutritionSummaryState createState() => _TodayNutritionSummaryState();
}

class _TodayNutritionSummaryState extends State<TodayNutritionSummary> {
  double _totalCarbs = 0;
  double _totalProtein = 0;
  double _totalFat = 0;
  double _totalCalories = 0;

  Color color = theme_orange;

  final cubit = sl.get<NutritionPlanCubit>();

  @override
  void initState() {
    super.initState();
    cubit.getDailyNutritionPlanSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 6,
          ),
        ],
      ),
      child: getSummary(),
    );
  }

  BlocBuilder<NutritionPlanCubit, NutritionPlanState> getSummary() {
    return BlocBuilder<NutritionPlanCubit, NutritionPlanState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is NutritionPlanLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NutritionPlanEmptyState) {
            return const Center(child: Text('No data'));
          } else if (state is NutritionPlanDailySummaryLoaded) {
            _totalCarbs = state.dailyNutritionPlanSummary.totalCarbs;
            _totalProtein = state.dailyNutritionPlanSummary.totalProtein;
            _totalFat = state.dailyNutritionPlanSummary.totalFat;
            _totalCalories = state.dailyNutritionPlanSummary.totalCalories;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NutrientColumn(
                    value: _totalCarbs, label: 'Carbs', color: color),
                NutrientColumn(
                    value: _totalProtein, label: 'Protein', color: color),
                NutrientColumn(value: _totalFat, label: 'Fat', color: color),
                NutrientColumn(
                    value: _totalCalories, label: 'Calories', color: color),
              ],
            );
          } else if (state is NutritionPlanErrorState) {
            return Text(state.message);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
