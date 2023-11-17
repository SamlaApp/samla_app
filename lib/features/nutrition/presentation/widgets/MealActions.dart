import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:flutter/services.dart';

class MealActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _mealCard(
      icon: Icons.food_bank,
      title: "Add custom calories",
    );
  }

  Widget _mealCard({
    required IconData icon,
    required String title,
  }) {
    return Container(
      height: 80,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Icon(icon, color: theme_darkblue, size: 30),
              SizedBox(width: 10),
              Text(
                title,
                style: greyTextStyle.copyWith(
                  fontSize: 15,
                  color: theme_darkblue.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _customButton(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: 120,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(title, style: TextStyle(fontSize: 16, color: Colors.white)),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: theme_green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        ),
      ),
    );
  }
}
