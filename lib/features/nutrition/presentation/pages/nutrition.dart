import 'package:flutter/material.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/nutrtiionPlan/nutritionPlan_cubit.dart';
import 'package:samla_app/features/nutrition/presentation/widgets/TodayNutritionSummary.dart';
import 'package:samla_app/features/nutrition/presentation/widgets/TodayPlan.dart';
import 'package:samla_app/features/nutrition/presentation/widgets/CustomSignedCalories.dart';
import 'package:samla_app/features/nutrition/presentation/widgets/Macronutrients.dart';
import 'package:samla_app/features/nutrition/nutrition_di.dart' as di;

class NutritionPage extends StatefulWidget {
  const NutritionPage({Key? key}) : super(key: key);

  @override
  _NutritionPageState createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  @override
  void initState() {
    super.initState();
  }

  final cubit = di.sl.get<NutritionPlanCubit>();

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TodayPlan(),
            const SizedBox(height: 20),
            const TodayNutritionSummary(),
            const SizedBox(height: 20),
            const CustomSignedCalories(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
