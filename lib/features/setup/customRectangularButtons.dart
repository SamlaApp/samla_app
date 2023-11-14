import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/setup/userMeasurment.dart';

class CustomRectangularButton extends StatelessWidget {
  final String iconPath;
  final String buttonText;
  final Color buttonColor;

  CustomRectangularButton({
    required this.iconPath,
    required this.buttonText,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final userProgress = userMeasurment();
        userProgress.updateGender(gender: buttonText);
      },
      child: Container(
        width: 220,
        height: 60,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Padding(
                padding: const EdgeInsets.only(
                    right:
                        45, //if u using just one button, then change it to be right:45
                    left: 10),
                child: Image.asset(
                  iconPath,
                  width: 42,
                  height: 42,
                  color: Colors.white,
                ),
              ),
            ),
            // const SizedBox(width: 10),
            Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRectangularButton2 extends StatelessWidget {
  final String iconPath;
  final String buttonText;
  final Color buttonColor;

  CustomRectangularButton2({
    required this.iconPath,
    required this.buttonText,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final userProgress = userMeasurment();
        userProgress.updateGender(gender: buttonText);
      },
      child: Container(
        width: 220,
        height: 60,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Padding(
                padding: const EdgeInsets.only(right: 30, left: 10),
                child: Image.asset(
                  iconPath,
                  width: 42,
                  height: 42,
                  color: Colors.white,
                ),
              ),
            ),
            // const SizedBox(width: 10),
            Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
