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

import '../pages/NutritionPlan.dart';

class TodayPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: background_gradient,
        borderRadius: primary_decoration.borderRadius,
        boxShadow: primary_decoration.boxShadow,
      ),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Today Plan', style: textStyle.copyWith(fontSize: 20, color: Colors.white)),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NutritionPlan()));

                },
                child: Text('Edit', style: greyTextStyle.copyWith(fontSize: 17, color: Colors.white)),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              foodItem('Egg', '30 kcal'),
              foodItem('Milk', '30 kcal'),
              foodItem('Bread', '30 kcal'),
              foodItem('Orange', '30 kcal'),
            ],
          ),
        ],
      ),
    );
  }

  Column foodItem(String foodName, String calValue) {
    return Column(
      children: [
        Icon(Icons.breakfast_dining, color: theme_green, size: 30),
        Text(foodName, style: greyTextStyle.copyWith(fontSize: 16, color: Colors.white)),
        Text(calValue, style: greyTextStyle.copyWith(fontSize: 16, color: Colors.white)),
      ],
    );
  }
}