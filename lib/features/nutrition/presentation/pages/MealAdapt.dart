import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/nutrition/data/models/nutritionPlan_model.dart';
import '../widgets/MaelAdapt/DayDropdown.dart';
import '../widgets/MaelAdapt/NutrientColumn.dart';
import '../widgets/MaelAdapt/foodItem.dart';

class MealAdapt extends StatelessWidget {
  final NutritionPlanModel nutritionPlan;

  const MealAdapt({super.key, required this.nutritionPlan});

  @override
  Widget build(BuildContext context) {
    String type = nutritionPlan.type;
    late IconData icon;
    late LinearGradient gradient;

    if (type == 'Breakfast') {
      icon = Icons.free_breakfast;
      gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          theme_green,
          Colors.blueAccent,
        ],
      );
    } else if (type == 'Lunch') {
      icon = Icons.lunch_dining;
      gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [theme_orange, Colors.red],
      );
    } else if (type == 'Dinner') {
      icon = Icons.dinner_dining;
      gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [theme_darkblue, theme_green],
      );
    } else if (type == 'Snack') {
      icon = Icons.fastfood;
      gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          theme_pink,
          Colors.blueAccent,
        ],
      );
    }

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 200.0,
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: gradient),
          ),
          title: Column(
            children: [
              Icon(icon, size: 80),
              const SizedBox(height: 5),
              Text(
                nutritionPlan.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '${nutritionPlan.start_time} - ${nutritionPlan.end_time}',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: theme_green,
            labelColor: primary_color,
            unselectedLabelColor: theme_grey,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            tabs: const [
              Tab(text: 'Your current plan'),
              Tab(text: 'Find more meals'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // First tab content
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          NutrientColumn(value: '30', label: 'Carbs'),
                          NutrientColumn(value: '24', label: 'Protein'),
                          NutrientColumn(value: '18', label: 'Fat'),
                          NutrientColumn(value: '350', label: 'Total kcal'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    DayDropdown(
                      days: const [
                        'Monday',
                        'Tuesday',
                        'Wednesday',
                        'Thursday',
                        'Friday',
                        'Saturday',
                        'Sunday'
                      ],
                      initialValue: 'Saturday',
                      onChanged: (value) {
                        print("Selected day: $value");
                      },
                    ),
                    const SizedBox(height: 20),
                    FoodItem(foodName: 'eggs', kcal: 22, onRemove: () {}),
                    FoodItem(foodName: 'tea', kcal: 213, onRemove: () {}),
                    FoodItem(foodName: 'meat', kcal: 234, onRemove: () {}),
                    FoodItem(foodName: 'apple', kcal: 187, onRemove: () {}),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            // Second tab content
            const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Hi there!'),
                    // more widget here
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



