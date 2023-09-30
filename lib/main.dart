import 'dart:io';

import 'package:flutter/material.dart';
import 'package:samla_app/core/auth/User.dart';
// import 'package:samla_app/features/main/presentation/pages/home.dart';
// import 'package:samla_app/features/main/presentation/widgets/mainPagesLayout.dart';
// import 'Auth/Log In/login_service.dart';
// import 'Auth/Sign Up/ui_screen.dart';
// import 'Auth/Sign Up/register_service.dart';
import 'config/router/app_router.dart'; // Import your logical code

void main() async {
  // final registerService = RegisterService();

  // // Test works FINE
  // // registerService.register(
  // //   name: 'uitest',
  // //   email: 'uitest@Test4.com',
  // //   username: 'uitest',
  // //   phone: '566661354',
  // //   dateOfBirth: '2000-09-13',
  // //   password: '12345678',
  // // );

  // // Test works FINE
  // loginWithEmailPassword(
  //   email: 'test@samla.com',
  //   password: '12345678',
  // );
  WidgetsFlutterBinding.ensureInitialized();
  User? user = await Auth.getUser();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  final initialRoute = user == null? '/login' : '/';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Samla App',
        initialRoute: initialRoute,
        routes: routes,
        builder: (context, child) {
          final mediaQueryData = MediaQuery.of(context);
          final scale = mediaQueryData.textScaleFactor
              .clamp(1.0, 1.4); // choose your max and min font sizes here
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
              child: child!);
        });
  }
}
