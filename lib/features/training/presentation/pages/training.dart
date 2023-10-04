import 'package:flutter/material.dart';
import 'package:samla_app/core/auth/User.dart';

class TrainingPage extends StatelessWidget {
  TrainingPage({super.key});

  final user = LocalAuth.user;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Training ${user.dateOfBirth}'),
    );
  }
}
