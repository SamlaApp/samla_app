import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/setup/SelectGenderPage.dart';

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
        //TODO: DO NOT ALLOW THE USER TO GO BACK OR ANYWHERE UNTIL HE FINISH THE SETUP
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.white),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
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
        child:
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double height = constraints.maxHeight;
            double width = constraints.maxWidth;
            print("The height of the container is $height");
            return welcomWidget(context, height, width);
          },
        ),
      ),
    );
  }

  Widget welcomWidget(BuildContext context, double height, double width) {
    return Container(
        width: width,
        padding: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
        
          mainAxisSize: MainAxisSize.max,          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                'images/WelcomePage-pic.png',
                // height: height * 0.4, // %40 of the screen height (remove expanded to use this)
                // width: height * 0.4,
              ),
            ),
           
            Text(
              "Welcome to Samla",
              style: TextStyle(
                  color: theme_darkblue,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Text(
              "Let’s start your journey now !",
              style: TextStyle(
                  color: theme_grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
            ),
            SizedBox(height: 20,), // ensure there is a space between the text and the button 
        
            Container(
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
                   //should navegate to SelectGenderPage
                   Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectGenderPage()));
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
          ],
        ),
      );
  }
}
