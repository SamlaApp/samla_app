import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _mealCard(
            icon: Icons.coffee,
            title: "Breakfast",
            subtitle: "300 kcal",
            buttons: ["Done", "Skip Meal"]),
        _mealCard(
            icon: Icons.local_fire_department,
            title: "Custom Calories",
            subtitle: "e.g. 30 kcal",
            buttons: ["Enter"]),
      ],
    );
  }
  Widget _mealCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<String> buttons,
  }) {
    return Container(
      width: 180,
      height: 180,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(icon, color: theme_darkblue, size: 30),
              SizedBox(width: 10), // A space between the icon and the text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: greyTextStyle.copyWith(
                      fontSize: 15,
                      color: theme_darkblue.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
          for (var btn in buttons) _customButton(btn),
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
          foregroundColor: Colors.white, backgroundColor: theme_green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        ),
      ),
    );
  }
}

