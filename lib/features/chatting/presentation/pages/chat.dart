import 'package:flutter/material.dart';
import 'package:samla_app/core/auth/User.dart';

class ChattingPage extends StatelessWidget {
  ChattingPage({super.key}
  );
  final user = LocalAuth.user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Chatting ${user.username}'),
    );
  }
}
