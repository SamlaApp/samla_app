import 'dart:io';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samla_app/core/auth/User.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'config/router/app_router.dart';
import 'firebase_options.dart'; // Import your logical code

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseInAppMessaging.instance.setAutomaticDataCollectionEnabled(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  
  // final initialRoute = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        });
  }
}
