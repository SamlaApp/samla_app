import 'dart:io';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/notifications/presentation/bloc/notification_bloc.dart';
import 'config/router/app_router.dart';
import 'features/auth/domain/entities/user.dart';
import 'firebase_options.dart'; // Import your logical code
import 'features/auth/auth_injection_container.dart' as auth_di;
import 'features/notifications/notification_injection_container.dart' as notifi_di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Massaging
  FirebaseInAppMessaging.instance.setAutomaticDataCollectionEnabled(true);
  FirebaseMessaging.onBackgroundMessage(_handleMessage);

  runApp(const MyApp());
}

Future<void> _handleMessage(RemoteMessage message) async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      showDialog(
        context: auth_di.sl(),
        builder: (BuildContext context) => AlertDialog(
          title: Text(notification.title!),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.body!),
                Text('data: ${message.data}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => auth_di.sl<AuthBloc>(),
      child: BlocProvider(
        create: (context) => notifi_di.sl<NotificationBloc>(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Samla App',
            initialRoute: '/',
            routes: routes,
            builder: (context, child) {
              final mediaQueryData = MediaQuery.of(context);
              final scale = mediaQueryData.textScaleFactor
                  .clamp(1.0, 1.4); // choose your max and min font sizes here
              // disable rotation
              if (mediaQueryData.orientation == Orientation.landscape) {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ]);
              }
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
                  child: child!);
            }),
      ),
    );
  }
}
