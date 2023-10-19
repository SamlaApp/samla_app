import 'package:flutter/material.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart' as di;


class NutritionPage extends StatelessWidget {
  NutritionPage({super.key});

  final user = di.getUser();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Nutrition ${user.email}'));
  }
}