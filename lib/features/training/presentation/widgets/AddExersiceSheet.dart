import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
class AddExerciseSheet extends StatelessWidget {


  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle filter button 1 press
                        },
                        child: const Text('Filter tt1'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme_green,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle filter button 2 press
                        },
                        child: const Text('Filtesssr 2'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme_green,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();  // This widget won't render anything itself
  }
}
