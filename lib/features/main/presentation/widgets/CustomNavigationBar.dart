import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    Color selectedColor = theme_darkblue.withOpacity(0.8);
    Color unselectedColor = theme_darkblue.withOpacity(0.5);
    String? currentRoute = ModalRoute.of(context)?.settings.name;

    return NavigationBarTheme(
      data: NavigationBarThemeData(
        backgroundColor: primary_color,
        indicatorColor: theme_darkblue.withOpacity(0.2),
        labelTextStyle: MaterialStateProperty.all(
            TextStyle(color: selectedColor, fontSize: 12)),
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
                icon: SvgPicture.asset(
                  'images/dumbbell.svg',
                  height: 32,
                  color: widget.index == 0 ? selectedColor : unselectedColor,
                ),
                label: "Training"),
            NavigationDestination(
                icon: SvgPicture.asset(
                  'images/nutrition.svg',
                  height: 23,
                  color: widget.index == 1 ? selectedColor : unselectedColor,
                ),
                label: "Nutrition"),
            NavigationDestination(
                icon: SvgPicture.asset(
                  'images/home.svg',
                  height: 30,
                  color: widget.index == 2 ? selectedColor : unselectedColor,
                ),
                label: "Home"),
            NavigationDestination(
                icon: SvgPicture.asset(
                  'images/community.svg',
                  height: 22,
                  color: widget.index == 3 ? selectedColor : unselectedColor,
                ),
                label: "Community"),
            NavigationDestination(
                icon: SvgPicture.asset(
                  'images/message.svg',
                  height: sizeOficon,
                  color: widget.index == 4 ? selectedColor : unselectedColor,
                ),
                label: "Chatting"),
            // NavigationDestination(
            //     icon: SvgPicture.asset(
            //       'images/profile.svg',
            //       height: 20,
            //       color: widget.index == 5 ? selectedColor : unselectedColor,
            //     ),
            //     label: "Profile")
          ],
        ),
      ),
    );
  }
}
