import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

class CustomNavigationBar extends StatefulWidget {
  final int index;
  final Function notifyParent;

  const CustomNavigationBar(
      {super.key, required this.index, required this.notifyParent});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    double sizeOficon = 25;
    Color selectedColor = theme_green;
    Color unselectedColor = theme_darkblue.withOpacity(0.5);

    return NavigationBarTheme(
      data: NavigationBarThemeData(
        backgroundColor: primary_color,
        indicatorColor: Colors.transparent,
        labelTextStyle: MaterialStateProperty.all(
            TextStyle(color: unselectedColor, fontSize: 12)),
      ),
      child: Container(
        decoration: primary_decoration,
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          height: 60,
          selectedIndex: widget.index < 5 ? widget.index : 0,
          onDestinationSelected: (index) => widget.notifyParent(index),
          destinations: [
            NavigationDestination(
                icon: Icon(Icons.fitness_center,
                    size: sizeOficon,
                    color: widget.index == 0 ? selectedColor : unselectedColor),
                label: "Training"),
            NavigationDestination(
                icon: Icon(Icons.fastfood_rounded,
                    size: sizeOficon,
                    color: widget.index == 1 ? selectedColor : unselectedColor),
                label: "Nutrition"),
            NavigationDestination(
                icon: Icon(Icons.home_filled,
                    size: sizeOficon,
                    color: widget.index == 2 ? selectedColor : unselectedColor),
                label: "Home"),
            NavigationDestination(
                icon: Icon(Icons.groups,
                    size: sizeOficon,
                    color: widget.index == 3 ? selectedColor : unselectedColor),
                label: "Community"),
            NavigationDestination(
                icon: Icon(Icons.help,
                    size: sizeOficon,
                    color: widget.index == 4 ? selectedColor : unselectedColor),
                label: "Assistant"),
          ],
        ),
      ),
    );
  }
}
