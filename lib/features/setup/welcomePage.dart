import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/setup/SelectGenderPage.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: Scaffold(
//       body: Center(
//         child: WelcomePage(),
//       ),
//     ),
//   ));
// }

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme_pink,
      appBar: AppBar(
        toolbarHeight: 200.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Image.asset(
              'images/Logo/White-logo.png',
              height: 60,
              width: 80,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: theme_pink,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Image.asset(
                      'images/WelcomePage-pic.png',
                      height: 400,
                      width: 400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(
                    "Welcome to Samla",
                    style: TextStyle(
                        color: theme_darkblue,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "Let’s start your journey now !",
                    style: TextStyle(
                        color: theme_grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                Center(
                  child: Container(
                    height: 67,
                    width: 67,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                        elevation: 4, //shadow
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        SelectGenderPage(); //should navegate to SelectGenderPage
                      },
                      // child: const Text(
                      //   '>',
                      //   style: TextStyle(
                      //     color: Color(0xFF0A2C40),
                      //     fontSize: 35,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 35,
                        color: Color(0xFF0A2C40),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
