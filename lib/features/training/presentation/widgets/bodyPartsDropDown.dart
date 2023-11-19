import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

class BodyPartDropdown extends StatefulWidget {
  final String? initialValue;
  final Function(String) onChanged;
  final Color color;
  final Color backgroundColor;

  const BodyPartDropdown({super.key,  this.initialValue, required this.onChanged, required this.color, required this.backgroundColor});

  @override
  _BodyPartDropdownState createState() => _BodyPartDropdownState();
}

class _BodyPartDropdownState extends State<BodyPartDropdown> {
  late String _currentPart;

  final List<String> parts = const [
    "Back",
    "Cardio",
    "Chest",
    "Lower arms",
    "Lower legs",
    "Neck",
    "Shoulders",
    "Upper arms",
    "Upper legs",
    "Waist"
  ];

  @override
  void initState() {
    super.initState();
    _currentPart = widget.initialValue ?? parts[0];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: inputField_color,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _currentPart,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade400),
                iconSize: 24,
                dropdownColor: widget.backgroundColor,
                style: TextStyle(color: widget.color, fontSize: 16),
                onChanged: (String? newValue) {
                  setState(() {
                    _currentPart = newValue!;
                    widget.onChanged(newValue);
                  });
                },
                items: parts.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
