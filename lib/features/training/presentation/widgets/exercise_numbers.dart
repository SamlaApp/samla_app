import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:io/ansi.dart';
import 'package:samla_app/config/themes/common_styles.dart';

class ExerciseNumbersWidget extends StatelessWidget {
  const ExerciseNumbersWidget({
    super.key,
  });

  final int setsNumber = 3;
  final int finishedSets = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
      decoration: primary_decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildButton(
            context,
            '10',
            'Repeats',
          ),
          buildButton(
            context,
            '00:00',
            'Rest',
          ),
          buildButton(
            context,
            '${finishedSets}/${setsNumber}',
            'Sets',
          )
        ],
      ),
    );
  }

  Widget buildButton(BuildContext context, String numbers, String text) =>
      MaterialButton(
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              numbers,
              style: TextStyle(fontSize: 18, color: theme_green),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      );
}
