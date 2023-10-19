
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        backgroundColor: theme_darkblue,
      ),
    );
  }
}
