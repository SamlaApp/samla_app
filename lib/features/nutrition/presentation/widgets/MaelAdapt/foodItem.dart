import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

class FoodItem extends StatelessWidget {
  final String foodName;
  final int kcal;
  final Function() onRemove;

  FoodItem({required this.foodName, required this.kcal, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.fastfood, color: theme_grey),
                SizedBox(width: 10),
                Text(
                  foodName,
                  style: TextStyle(
                    fontSize: 16,
                    color:theme_grey,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '$kcal kcal',
                  style: TextStyle(
                    fontSize: 14,
                    color: theme_grey,
                  ),
                ),
              ],
            ),

            InkWell(
              onTap: onRemove,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: theme_red, width: 2),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    'Remove',
                    style: TextStyle(
                      color: theme_red,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),

                  ),
                ),

              ),
            ),
          ],

        ),
      ),

    );

  }
}