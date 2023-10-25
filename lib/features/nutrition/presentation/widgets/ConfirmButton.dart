import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  final String label;

  ConfirmButton(this.label);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // Add action for the confirm button
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF00BCD4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(label, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
