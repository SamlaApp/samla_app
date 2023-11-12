import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

class DayDropdown extends StatefulWidget {
  final List<String> days;
  final String? initialValue;
  final Function(String) onChanged;
  final Color color;
  final Color backgroundColor;

  DayDropdown({required this.days, this.initialValue, required this.onChanged, required this.color, required this.backgroundColor});

  @override
  _DayDropdownState createState() => _DayDropdownState();
}

class _DayDropdownState extends State<DayDropdown> {
  late String _currentDay;

  // get currentDay => _currentDay;






  @override
  void initState() {
    super.initState();
    _currentDay = widget.initialValue ?? widget.days[0];
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
                value: _currentDay,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade400),
                iconSize: 24,
                dropdownColor: widget.backgroundColor,
                style: TextStyle(color: widget.color, fontSize: 16),
                onChanged: (String? newValue) {
                  setState(() {
                    _currentDay = newValue!;
                    widget.onChanged(newValue);
                  });
                },
                items: widget.days.map<DropdownMenuItem<String>>((String value) {
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
