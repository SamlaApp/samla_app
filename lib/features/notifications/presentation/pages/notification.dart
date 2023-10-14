import 'package:flutter/material.dart';
import 'package:samla_app/core/auth/User.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(),
      body: Center(child: FloatingActionButton(onPressed: () => {LocalAuth.resetCacheUser(), Navigator.of(context).pushNamedAndRemoveUntil(
          '/login', (Route<dynamic> route) => false)}, child: Text('Logout'),),),);
  }
}