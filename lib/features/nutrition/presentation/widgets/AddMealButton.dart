import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../config/themes/common_styles.dart';


typedef NavigationAction = void Function(BuildContext context);

class AddMealButton extends StatelessWidget {
  final NavigationAction onButtonPressed;

  AddMealButton({required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onButtonPressed(context),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: theme_grey, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, color: theme_grey, size: 40),
            SizedBox(width: 10),
            Text(
              'Add new food',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}