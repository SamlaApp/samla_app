import 'dart:io';

import 'package:flutter/material.dart';
import 'Auth/Log In/login_service.dart';
import 'Auth/Sign Up/ui_screen.dart';
import 'Auth/Sign Up/register_service.dart'; // Import your logical code
import 'package:io/io.dart';
Future<void> main() async {
//   final registerService = RegisterService();

  // Generate New OTP (Must have an account in dataGrip)
  // loginWithPhoneNumber(
  //     phoneNumber: '+966566661354',
  // );

  requestOTPWithPhoneNumber(
    phoneNumber: '+966566661354',
    otp: '3379',
  );


    // Test works FINE
  // registerService.register(
  //   name: 'uitest',
  //   email: 'uitest@Test4.com',
  //   username: 'uitest',
  //   phone: '566661354',
  //   dateOfBirth: '2000-09-13',
  //   password: '12345678',
  // );

  // Tests works FINE
  // loginWithEmailPassword(
  //   email: 'test@samla.com',
  //   password: '12345678',
  // );
  //
  // loginWithUserNamePassword(
  //   username: 'samla_user',
  //   password: '12345678',
  // );
   // runApp(MyApp());
 }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Your App',
//       initialRoute: '/register',
//       routes: {
//         '/register': (context) => RegisterScreen(), // make new Route pallllez
//         //PUT here more routes...
//       },
//     );
//   }
// }


