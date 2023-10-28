import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

class NutrientColumn extends StatelessWidget {
  final String value;
  final String label;

  NutrientColumn({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme_green)),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }
}
