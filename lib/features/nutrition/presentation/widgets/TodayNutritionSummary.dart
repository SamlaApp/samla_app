import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/features/nutrition/nutrition_di.dart' as di;
import 'package:samla_app/features/nutrition/presentation/cubit/summary/summary_cubit.dart';
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

  Color color = themeOrange;

  final summaryCubit = di.sl.get<SummaryCubit>();

  @override
  void initState() {
    super.initState();
    summaryCubit.getDailyNutritionPlanSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: primaryDecoration,
      child: getSummary(),
    );
  }

  BlocBuilder<SummaryCubit, SummaryState> getSummary() {
    return BlocBuilder<SummaryCubit, SummaryState>(
        bloc: summaryCubit,
        builder: (context, state) {
          if (state is SummaryLoadingState) {
            return  const Center(child: CircularProgressIndicator(
              color: themeBlue,
              backgroundColor: themePink,
            ),);
          } else if (state is SummaryEmptyState) {
            return const Center(child: Text('No data'));
          } else if (state is SummaryLoaded) {
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
          } else if (state is SummaryErrorState) {
            return Text(state.message);
          } else {
            summaryCubit.getDailyNutritionPlanSummary();
            return  const Center(child: CircularProgressIndicator(
              color: themeBlue,
              backgroundColor: themePink,
            ),);
          }
        });
  }
}
