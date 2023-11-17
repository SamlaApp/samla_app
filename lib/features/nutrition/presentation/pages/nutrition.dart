import 'package:flutter/material.dart';
import '../widgets/CaloriesOverview.dart';
import '../widgets/Macronutrients.dart';
import '../widgets/MealActions.dart';
import '../widgets/TodayPlan.dart';
import 'package:samla_app/features/nutrition/nutrition_di.dart' as di;

class NutritionPage extends StatefulWidget{

  const NutritionPage({Key? key}) : super(key: key);

  @override
  _NutritionPageState createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {

  @override
  void initState() {
    super.initState();
    di.NutritionInit();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TodayPlan(),
            const SizedBox(height: 20),
            MealActions(),
            const SizedBox(height: 20),
            //CaloriesOverview(),
            const SizedBox(height: 20),
            Macronutrients(),


            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
