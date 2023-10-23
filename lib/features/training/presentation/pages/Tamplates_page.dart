import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

class TemplatesPage extends StatelessWidget {
  TemplatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data: Replace this with your actual data
    final templates = [
      {
        'templateName': 'Template 1',
        'days': [
          {
            'dayName': 'Day 1 - Pull Routine',
            'exercises': 'Pull-Ups, Chin-Ups, Rows',
          },
          // Add more days here
        ],
      },
      // Add more templates here
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Templates'),
        backgroundColor: theme_green, // Replace with your theme color
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: theme_green, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Start Empty WorkOut',
                      style: TextStyle(
                          color: theme_green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Templates',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement the functionality for adding a new template
                  },
                  child: Text('+Template'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        theme_green, // Replace with your theme color
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: templates.length,
                itemBuilder: (context, index) {
                  final template = templates[index];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            template['templateName'] as String,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          ...(template['days'] as List).map<Widget>((day) {
                            // Cast to List, telling Dart you expect a non-null List
                            return Card(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (day as Map)['dayName'] as String,
                                      // Cast to Map and then String, telling Dart you expect a non-null Map and then a non-null String
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text((day as Map)['exercises'] as String),
                                    // Cast to Map and then String, same reason as above
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
