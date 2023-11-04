import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/NutritionPlan/nutritionPlan_cubit.dart';
import 'MealAdapt.dart';
import 'newMeal.dart';
import 'package:samla_app/features/nutrition/nutrition_di.dart' as di;

class NutritionPlan extends StatefulWidget {
  const NutritionPlan({Key? key}) : super(key: key);

  @override
  _NutritionPlanState createState() => _NutritionPlanState();
}

class _NutritionPlanState extends State<NutritionPlan> {

  final cubit = NutritionPlanCubit(di.sl.get());

  @override
  Widget build(BuildContext context) {
    cubit.getAllNutritionPlans();
    return BlocBuilder<NutritionPlanCubit, NutritionPlanState>(
        bloc: cubit,
        builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Nutrition Plan",
                  style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NewMeal(),
                        ),
                      );
                    },
                  ),
                ],
                flexibleSpace: AnimateGradient(
                  primaryBegin: Alignment.topLeft,
                  primaryEnd: Alignment.bottomLeft,
                  secondaryBegin: Alignment.bottomRight,
                  secondaryEnd: Alignment.topLeft,
                  primaryColors: [
                    theme_green,
                    Colors.blueAccent,
                  ],
                  secondaryColors: [
                    theme_green,
                    const Color.fromARGB(255, 120, 90, 255)
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    mealCard(
                      context,
                      icon: Icons.coffee_rounded,
                      title: "Breakfast Meal",
                      time: "05:00am - 09:00am",
                      gradient: LinearGradient(
                        colors: [theme_green, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    mealCard(
                      context,
                      icon: Icons.food_bank,
                      title: "Lunch Meal",
                      time: "12:00pm - 03:00pm",
                      gradient: LinearGradient(
                        colors: [theme_orange, Colors.red],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    mealCard(
                      context,
                      icon: Icons.dinner_dining,
                      title: "Dinner Meal",
                      time: "05:00am - 09:00am",
                      gradient: LinearGradient(
                        colors: [theme_darkblue, theme_green],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ],
                ),
              ),
            );

        });
  }

  Widget mealCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String time,
      required LinearGradient gradient}) {
    return GestureDetector(
      onTap: () {
        // Navigator HERE bro!! (Change it later)
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const MealAdapt()));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 50),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
