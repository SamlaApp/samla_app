import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';

class JoinRequestsPage extends StatelessWidget {
  const JoinRequestsPage({super.key, required this.community});
  final Community community;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Join Requests'),),
      body: const Center(
        child: Text('Join Requests'),
      ),
    );
  }
}