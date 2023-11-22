import 'package:flutter/material.dart';

import '../../../../config/themes/common_styles.dart';
import '../pages/startTrainig.dart';

Widget buildGradientBorderButton(BuildContext context) {
  return InkWell(
    onTap: () {
      /*
      print('Start Clicked');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => startTraining(), // This is your Start Training page widget
        ),
      );

       */

    },
    child: Padding(
      padding: const EdgeInsets.all(7.0),
      child: Container(
        padding: EdgeInsets.all(4), // Padding for the gradient border
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11), // slightly larger radius for the border
          gradient: LinearGradient(
            colors: [theme_darkblue, Colors.red],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color: Colors.white, // White background
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [theme_darkblue, Colors.red],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds);
                },
                child: Text(
                  'Start Now',
                  style: TextStyle(
                    color: Colors.white, // This color is important to make gradient visible
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(), // Use Spacer for even spacing
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [theme_darkblue, Colors.red],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}