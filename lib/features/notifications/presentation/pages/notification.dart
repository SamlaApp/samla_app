import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart' as di;
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';

class NotificationsPage extends StatefulWidget {
  NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final authBloc = di.sl.get<AuthBloc>();

  final user = di.sl.get<AuthBloc>().user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is LoadingAuthState) {
          return const Scaffold(
            body: Center(
              // shows loading indicator while state is Loading
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ErrorAuthState) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            authBloc.add(ClearAuthEvent());
          });
        }
        // else return the widget
        return NotificationWidget(context);
      },
    );
  }

//TODO: it just for testing, delete all this shit 😊

  Scaffold NotificationWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Notifications ${user.name}'),
            FloatingActionButton(
              onPressed: () {
                authBloc.add(LogOutEvent(context));
              },
              child: const Text('Logout'),
            ),
            TextButton(
              onPressed: () {
                authBloc.add(UpdateUserEvent(
                  name: 'Laru',
                  email: 'ridha@samla.com',
                ));
              },
              child: const Text('update name'),
            ),
          ],
        ),
      ),
    );
  }
}
