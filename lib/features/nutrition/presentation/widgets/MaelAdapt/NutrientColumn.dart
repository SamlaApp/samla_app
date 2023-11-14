import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NutrientColumn extends StatelessWidget {
  final num value;
  final String label;
  final Color color;


  const NutrientColumn({super.key, required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }
}
