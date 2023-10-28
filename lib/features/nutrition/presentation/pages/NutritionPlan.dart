import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import '../widgets/addMealButtom.dart';
import 'MealAdapt.dart';
import 'newMeal.dart';

class NutritionPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Nutrition Plan"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            AddMealButton(
              onButtonPressed: (context) {
                // Your custom navigation action here.
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewMeal(),
                  ),
                );
              },
            ),

            SizedBox(height: 40),
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
            SizedBox(height: 40),
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
            SizedBox(height: 40),
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
  }


  Widget mealCard(BuildContext context, {required IconData icon, required String title, required String time, required LinearGradient gradient}) {
    return GestureDetector(
      onTap: () {
        // Navigator HERE bro!! (Change it later)
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MealAdapt()));
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 60),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

