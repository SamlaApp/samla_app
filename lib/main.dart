import 'dart:io';

import 'package:flutter/material.dart';
import 'package:samla_app/core/auth/User.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'config/router/app_router.dart'; // Import your logical code

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
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
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
              child: child!);
        });
  }
}
