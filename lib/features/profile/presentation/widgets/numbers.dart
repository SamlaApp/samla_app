import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({super.key});

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
            '0',
            'Friends',
          ),
          buildButton(
            context,
            '0',
            'Gyms',
          ),
          buildButton(
            context,
            '0',
            'Followers',
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
