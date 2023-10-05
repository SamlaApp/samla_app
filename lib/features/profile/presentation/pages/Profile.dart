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
                await LocalAuth.resetCacheUser();
                await Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              }),
          TextButton(
            onPressed: () async {
              // dummy update for testing 
              String name = 'user ${DateTime.now().millisecondsSinceEpoch}';
              await LocalAuth.updateUser(name: name);
              // await Navigator.pushNamedAndRemoveUntil(
              //     context, '/MainPages', (route) => false);
            },
            child: Text('update'),
          ),
        ],
      )),
    );
  }
}
