// you have to specify the routes here beside their screens

import 'package:flutter/material.dart';
import 'package:samla_app/core/widgets/loading.dart';
import 'package:samla_app/features/auth/presentation/pages/Login.dart';
import 'package:samla_app/features/auth/presentation/pages/OTP.dart';
import 'package:samla_app/features/auth/presentation/pages/Register.dart';
import 'package:samla_app/features/machines/presentation/pages/QRpage.dart';
import 'package:samla_app/features/main/presentation/widgets/mainPagesLayout.dart';
import 'package:samla_app/features/notifications/presentation/pages/notification.dart';
import 'package:samla_app/features/profile/presentation/pages/Profile.dart';


Map<String, Widget Function(BuildContext)> routes = {
  '/MainPages': (context) => MainPages(), // main pages route contains the bottom navigation bar pages
  '/Notifications':(context) => NotificationsPage(),
  '/Profile':(context) => ProfilePage(), 
  '/QRcode': (context) => QRPage(),
  '/login' : (context) => Login(),
  '/' : (context) => LoadingScreen(),
  '/Register' : (context) => RegisterPage(),

};
