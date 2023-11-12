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
        color: theme_darkblue,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, color: theme_grey, size: 40),
             SizedBox(width: 10),
             Text(
              'Add new food',
              style: TextStyle(
                color: theme_green,
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