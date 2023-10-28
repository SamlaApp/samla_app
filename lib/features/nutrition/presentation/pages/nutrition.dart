import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart' as di;
import '../../../../main.dart';
import '../../../nutrition/presentation/widgets/CircularIndicators.dart';
import '../widgets/CaloriesOverview.dart';
import '../widgets/Macronutrients.dart';
import '../widgets/MealActions.dart';
import '../widgets/TodayPlan.dart';
import 'newMeal.dart';

class NutritionPage extends StatelessWidget {
  NutritionPage({super.key});

  final user = di.getUser();

  @override
  Widget build(BuildContext context) {
    return Container(

      child: SingleChildScrollView(
        child: Padding(

          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TodayPlan(),
              SizedBox(height: 20),
              CaloriesOverview(),
              SizedBox(height: 20),
              Macronutrients(),
              SizedBox(height: 20),
              MealActions(),
              SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}
