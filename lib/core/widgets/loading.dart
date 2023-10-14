import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

Widget LoadingWidget() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 50, horizontal: 100),
    color: primary_color.withOpacity(0.5),
    child: BackdropFilter(
      filter:
          ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Adjust the blur as needed
      child: Container(
        color: Colors.white.withOpacity(0), // Adjust opacity as needed
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/Logo/2x/Icon_1@2x.png',
                    height: 60,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  LinearProgressIndicator(
                    color: theme_pink,
                    backgroundColor: theme_green,
                    semanticsLabel: 'Linear progress indicator',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
