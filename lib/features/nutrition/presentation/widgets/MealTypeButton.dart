import 'package:flutter/material.dart';
class MealTypeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<String> onSelected;

  MealTypeButton({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          onTap: () => onSelected(label),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFF00BCD4) : Colors.white,
              border: Border.all(
                color: isSelected ? Color(0xFF00BCD4) : Colors.grey[300]!,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: isSelected ? [BoxShadow(blurRadius: 3, color: Colors.grey.withOpacity(0.3), offset: Offset(0, 2))] : [],
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: isSelected ? Colors.white : Colors.grey[600],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
