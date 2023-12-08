import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/core/widgets/CustomTextFormField.dart';

class FriendsPage extends StatefulWidget {
  FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final _searchController = TextEditingController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: inputFieldColor,
      height: double.maxFinite,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Search bar
              Container(
                decoration: primaryDecoration,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: _searchController,
                            label: 'Search for friends',
                            iconData: Icons.search,
                          ),
                        ),
                      ],
                    ),
                    ButtonsBar(selectedIndex, (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),
              Container(
                decoration: primaryDecoration,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Content for My Friends or Explore
                    selectedIndex == 0 ? myFriendsBuilder() : exploreBuilder(),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget myFriendsBuilder() {
    // Logic to build the My Friends section
    return Center(
      child: Text(
        'My Friends List',
        style: TextStyle(
            color: themeDarkBlue.withOpacity(0.7),
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget exploreBuilder() {
    // Logic to build the Explore section
    return Center(
      child: Text(
        'Explore Content',
        style: TextStyle(
            color: themeDarkBlue.withOpacity(0.7),
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}

Widget ButtonsBar(int currentIndex, Function(int) onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Container(
          decoration: currentIndex == 0
              ? const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: themeBlue, width: 3.0),
            ),
          )
              : null,
          child: TextButton(
            onPressed: () => onTap(0),
            child: Text(
              'My Friends',
              style: TextStyle(
                color: currentIndex == 0 ? themeBlue : themeGrey,
                fontSize: 16,
                fontWeight:
                currentIndex == 0 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          decoration: currentIndex == 1
              ? const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: themeBlue, width: 3.0),
            ),
          )
              : null,
          child: TextButton(
            onPressed: () => onTap(1),
            child: Text(
              'Explore',
              style: TextStyle(
                color: currentIndex == 1 ? themeBlue : themeGrey,
                fontSize: 16,
                fontWeight:
                currentIndex == 1 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
