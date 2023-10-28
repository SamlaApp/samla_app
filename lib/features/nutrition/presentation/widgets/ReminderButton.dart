import 'package:flutter/material.dart';

class ReminderButton extends StatelessWidget {
  final String label;
  final ValueChanged<String> onSelected;
  final bool isSelected;

  ReminderButton(this.label, {required this.onSelected, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Colors.grey[700]!,
        backgroundColor: isSelected ? Color(0xFF00BCD4) : Colors.white,
        side: BorderSide(color: isSelected ? Color(0xFF00BCD4) : Colors.grey[400]!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      ),
      onPressed: () => onSelected(label),
      child: Text(
        label,
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }
}
