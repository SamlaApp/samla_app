// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:samla_app/core/auth/User.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = LocalAuth.user;
    print('rebuild profile page');
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          TextButton(
              child: Text('logout ${user.name}'),
              onPressed: () async {
                // TODO:put the backend request here

                // if backend return success, remove the user from the local storage
                await LocalAuth.resetCacheUser();
                await Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              }),
          TextButton(
            child: Text('update'),
            onPressed: () async {
              // TODO:put the backend logic here

              // if backend return success, update the user in the local storage
              // dummy update for testing
              String newName = 'user ${DateTime.now().millisecondsSinceEpoch}';
              await LocalAuth.updateUser(name: newName);
              await Navigator.pushNamedAndRemoveUntil(
                  context, '/MainPages', (route) => false);
            },
          ),
        ],
      )),
    );
  }
}
