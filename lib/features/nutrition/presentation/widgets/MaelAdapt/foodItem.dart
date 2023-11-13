import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';


class FoodItem extends StatefulWidget {
  final String foodName;
  final double kcal;
  final double fat;
  final double protein;
  final double carbs;
  final VoidCallback onRemove;

  const FoodItem({
    Key? key,
    required this.foodName,
    required this.kcal,
    required this.onRemove, required this.fat, required this.protein, required this.carbs,
  }) : super(key: key);

  @override
  _FoodItemState createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  bool _isRemoved = false;

  void _handleRemove() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm"),
          content: Text("Are you sure you want to remove this item?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                widget.onRemove();
                setState(() {
                  _isRemoved = true;
                });
                Navigator.of(context).pop();
              },
              child: Text("Remove"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isRemoved) {
      return Container();
    }

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
                  widget.foodName,
                  style: TextStyle(
                    fontSize: 16,
                    color: theme_grey,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '${widget.kcal} kcal',
                  style: TextStyle(
                    fontSize: 14,
                    color: theme_grey,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: _handleRemove,
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
