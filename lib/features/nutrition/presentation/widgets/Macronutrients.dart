import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:flutter/services.dart';

class Macronutrients extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: primary_decoration,
      child: Column(
        children: [
          nutrientRow('Carbs', 0.54),
          const SizedBox(height: 5),
          nutrientRow('Protein', 0.63),
          const SizedBox(height: 5),
          nutrientRow('Fat', 0.2),
        ],
      ),
    );
  }
  Widget nutrientRow(String nutrient, double percentage) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(nutrient, style: TextStyle(fontSize: 16, color: theme_grey)),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: inputField_color,
                valueColor: AlwaysStoppedAnimation<Color>(
                  nutrient == "Carbs"
                      ? themeBlue
                      : nutrient == "Protein"
                      ? themePink
                      : theme_orange,
                ),
                minHeight: 5, // Adjust height for the line style
                borderRadius: BorderRadius.circular(10), // Rounded corners

              ),
            ),
            const SizedBox(width: 10),
            Text('${(percentage * 100).toInt()}%', style: TextStyle(fontSize: 16, color: theme_grey)),
          ],
        ),
      ],
    );
  }

}
