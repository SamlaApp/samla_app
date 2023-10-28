import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

class DayDropdown extends StatefulWidget {
  final List<String> days;
  final String? initialValue;
  final Function(String) onChanged;

  DayDropdown({required this.days, this.initialValue, required this.onChanged});

  @override
  _DayDropdownState createState() => _DayDropdownState();
}

class _DayDropdownState extends State<DayDropdown> {
  late String _currentDay;

  @override
  void initState() {
    super.initState();
    _currentDay = widget.initialValue ?? widget.days[0];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20),

        Text(
          "Day",
          style: TextStyle(color: theme_green, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: inputField_color,
              borderRadius: BorderRadius.circular(15.0),

            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _currentDay,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.grey.shade800, fontSize: 16),
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
