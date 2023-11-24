import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:flutter/services.dart';
import 'package:samla_app/features/nutrition/nutrition_di.dart' as di;
import 'package:samla_app/features/nutrition/presentation/cubit/summary/summary_cubit.dart';

class CustomSignedCalories extends StatefulWidget {
  const CustomSignedCalories({super.key});

  _CustomSignedCaloriesState createState() => _CustomSignedCaloriesState();
}

class _CustomSignedCaloriesState extends State<CustomSignedCalories> {
  final summaryCubit = di.sl.get<SummaryCubit>();
  int _calories = 0;

  @override
  void initState() {
    super.initState();
    summaryCubit.getDailyNutritionPlanSummary();
  }

  @override
  Widget build(BuildContext context) {
    return _mealCard(
      icon: Icons.food_bank,
      title: "Custom Calories",
    );
  }

  Widget _mealCard({
    required IconData icon,
    required String title,
  }) {
    return Container(
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: primaryDecoration,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(icon, color: white, size: 30),
                  const SizedBox(width: 10),
                  Text(
                    title,
                  ),
                ],
              ),
              Container(
                width: 150,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: primaryDecoration,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _calories = int.parse(value);
                    });
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    hintText: 'Enter Calories',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                    border: InputBorder.none,
                    alignLabelWithHint: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add, color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: themeBlue,
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onPressed: () {
                // check if the calories is not 0
                if (_calories > 0) {
                  summaryCubit.setCustomCalories(_calories);
                  summaryCubit.getDailyNutritionPlanSummary();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Calories added successfully'),
                    ),
                  );

                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid number'),
                    ),
                  );
                }
              },
              label: const Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
