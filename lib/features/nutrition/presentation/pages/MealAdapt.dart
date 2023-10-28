import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

import '../widgets/MaelAdapt/DayDropdown.dart';
import '../widgets/MaelAdapt/NutrientColumn.dart';
import '../widgets/MaelAdapt/foodItem.dart';
import '../widgets/addMealButtom.dart';
import 'NutritionPlan.dart';

class MealAdapt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200.0,
        backgroundColor: theme_darkblue,

        title: Column(
          children: [
            Icon(Icons.free_breakfast, size: 80),
            SizedBox(height: 8),

            SizedBox(height: 5),
            Text('Breakfast Meal',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Text(
              '05:00am - 09:00am',
              style: TextStyle(fontSize: 14),
            ),

          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, size: 30),
            onPressed: () {},
          ),

        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              SizedBox(height: 20),


              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
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


              SizedBox(height: 20),


              DayDropdown(
                days: [
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                  'Sunday'
                ],
                initialValue: 'Saturday',
                // This is optional, remove if you want the first item in the list to be default
                onChanged: (value) {
                  // Do something when the day changes, for example:
                  print("Selected day: $value");
                },
              ),


              SizedBox(height: 20),
              FoodItem(foodName: 'Egg', kcal: 100, onRemove: () {
                // Logic for removing the food item goes here
              }),
              FoodItem(foodName: 'Egg', kcal: 100, onRemove: () {
                // Logic for removing the food item goes here
              }),
              FoodItem(foodName: 'Egg', kcal: 100, onRemove: () {
                // Logic for removing the food item goes here
              }),
              FoodItem(foodName: 'Egg', kcal: 100, onRemove: () {
                // Logic for removing the food item goes here
              }),
              SizedBox(height: 30),

              AddMealButton(
                onButtonPressed: (context) {
                  // Your custom navigation action here.
                  Navigator.of(context).push(
                    MaterialPageRoute(

                      //Todo: Change this to the new page
                      builder: (context) => NutritionPlan(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}