import 'package:flutter/material.dart';
import 'package:io/ansi.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/profile/data/goals_repository.dart';
import 'package:samla_app/features/setup/customRectangularButtons.dart';
import 'package:samla_app/features/setup/setHeightPage.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart'
    as authDI;

@override
Widget GenderWidget(BuildContext context, double height, double width,
    Function(String) callback) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(
        'images/SelectGender-pic.png',
        height: height * 0.4,
      ),
      Text(
        "Select Your Gender",
        style: TextStyle(
            color: theme_darkblue.withOpacity(0.9),
            fontWeight: FontWeight.bold,
            fontSize: 26),
      ),
      SizedBox(
        height: 20,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: theme_green,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            width: width * 0.8,
            height: 50,
            child: TextButton.icon(
                label: const Text(
                  'MALE',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  callback('male');
                },
                icon: Icon(
                  Icons.male,
                  color: Colors.white,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            // border radius
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: theme_pink,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            width: width * 0.8,
            height: 50,
            child: TextButton.icon(
                label: const Text(
                  'FEMALE',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  callback('female');
                },
                icon: Icon(
                  Icons.female,
                  color: Colors.white,
                )),
          ),
        ],
      ),
      const SizedBox(
        height: 60,
      ),
    ],
  );
}
