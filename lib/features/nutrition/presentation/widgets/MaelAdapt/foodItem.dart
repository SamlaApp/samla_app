import 'package:flutter/material.dart';

class FoodItem extends StatefulWidget {
  final String foodName;
  final double kcal;
  final double fat;
  final double protein;
  final double carbs;
  final LinearGradient gradient;
  final VoidCallback onRemove;
  final int size;

  const FoodItem({
    Key? key,
    required this.foodName,
    required this.kcal,
    required this.onRemove, required this.fat, required this.protein, required this.carbs, required this.gradient, required this.size,
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
          title: const Text("Confirm"),
          content: const Text("Are you sure you want to remove this item?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                widget.onRemove();
                setState(() {
                  _isRemoved = true;
                });
                Navigator.of(context).pop();
              },
              child: const Text("Remove"),
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

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: widget.gradient,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            widget.foodName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Carbs',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${widget.carbs}g',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Protein',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${widget.protein}g',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Fat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${widget.fat}g',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  const Text(
                    'Calories',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${widget.kcal}kcal',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),

                ],
              ),
              Column(
                children: [
                  const Text(
                    'Size',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${widget.size}g',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
        trailing: IconButton(
          onPressed: _handleRemove,
          icon: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
