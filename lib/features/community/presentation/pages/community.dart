import 'package:flutter/material.dart';
import 'package:samla_app/core/auth/User.dart';

class CommunityPage extends StatelessWidget {
  CommunityPage({super.key});

  final user = LocalAuth.user;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Community ${user.name}'),
      ),
    );
  }
}
