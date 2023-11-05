import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import '../widgets/exercise_tile.dart';
import 'ex.dart';
import 'dart:async';

class startTraining extends StatelessWidget {
  final Routine routine = dummyRoutines[0];  // Assuming you want to show the first routine

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(routine.title, style: TextStyle(color: Colors.white)),
        backgroundColor: theme_green,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'images/qrcode.svg',
              color: Colors.white,
            ),
            onPressed: () => Navigator.pushNamed(context, '/QRcode'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Timer: 00:00',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: routine.exercises.length,
                itemBuilder: (context, index) {
                  return ExerciseTile(exercise: routine.exercises[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

