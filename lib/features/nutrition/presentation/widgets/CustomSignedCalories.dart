import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:flutter/services.dart';
import 'package:samla_app/features/nutrition/domain/repositories/nutritionPlan_repository.dart';
import 'package:samla_app/features/nutrition/nutrition_di.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/nutritionPlan_cubit.dart';

class CustomSignedCalories extends StatefulWidget {
  const CustomSignedCalories({super.key});

  _CustomSignedCaloriesState createState() => _CustomSignedCaloriesState();
}

class _CustomSignedCaloriesState extends State<CustomSignedCalories> {
  final cubit = sl.get<NutritionPlanCubit>();

  @override
  void initState() {
    super.initState();
    cubit.getDailyNutritionPlanSummary();
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(icon, color: theme_darkblue, size: 30),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: greyTextStyle.copyWith(
                      fontSize: 15,
                      color: theme_darkblue.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              Container(
                width: 150,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    hintText: "e.g. 100",
                    hintStyle: greyTextStyle.copyWith(
                      fontSize: 15,
                      color: theme_darkblue.withOpacity(0.7),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: theme_green,
                        width: 0.2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: theme_green,
                        width: 0.2,
                      ),
                    ),
                    focusColor: theme_green,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add, color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme_darkblue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              label: const Text('Add'),
            ),
          ),
        ],
      ),
    );
  }
}
