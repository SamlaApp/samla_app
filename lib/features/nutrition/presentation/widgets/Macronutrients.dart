import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:flutter/services.dart';

class Macronutrients extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      decoration: primary_decoration,
      child: Column(
        children: [
          nutrientRow('Carbs', 0.95),
          SizedBox(height: 10),
          nutrientRow('Protein', 0.60),
          SizedBox(height: 10),
          nutrientRow('Fat', 0.52),
        ],
      ),
    );
  }
  Widget nutrientRow(String nutrient, double percentage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(nutrient, style: TextStyle(fontSize: 20, color: Colors.grey)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: inputField_color,
              valueColor: AlwaysStoppedAnimation<Color>(
                nutrient == "Carbs"
                    ? theme_green
                    : nutrient == "Protein"
                    ? theme_pink
                    : theme_orange,
              ),
            ),
          ),
        ),
        Text('${(percentage * 100).toInt()}%', style: TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }
}
