import 'package:flutter/material.dart';
import 'package:samla_app/core/auth/User.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = LocalAuth.user;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: FloatingActionButton(
              child: Text(user.name),
              onPressed: () async {
                await LocalAuth.resetCacheUser();
                await Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              })),
    );
  }
}
