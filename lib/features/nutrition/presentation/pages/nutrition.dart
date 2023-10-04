import 'package:flutter/material.dart';
import 'package:samla_app/core/auth/User.dart';

class NutritionPage extends StatelessWidget {
  NutritionPage({super.key});

  final user = LocalAuth.user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Nutrition ${user.email}'));
  }
}