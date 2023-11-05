import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

class TemplatesPage extends StatelessWidget {
  TemplatesPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> templates = [
    {
      'templateName': 'Template 1',
      'days': [
        {
          'dayName': 'Day 1 - Pull Routine',
          'exercises': 'Pull-Ups, Chin-Ups, Rows',
        },
        {
          'dayName': 'Day 2 - Leg Routine',
          'exercises': 'Squats, Lunges, Deadlifts',
        },
        {
          'dayName': 'Day 3 - Chest Workout',
          'exercises': 'Bench Press, Push-Ups, Dumbbell Flyes',
        },
        {
          'dayName': 'Day 4 - Cardio',
          'exercises': 'Running, Cycling, Jumping Jacks',
        },
        // Add more days here
      ],
    },
    {
      'templateName': 'Template 2',
      'days': [
        {
          'dayName': 'Day 1 - Push Routine',
          'exercises': 'Push-Ups, Dips, Bench Press',
        },
        {
          'dayName': 'Day 2 - Core Workout',
          'exercises': 'Planks, Sit-Ups, Russian Twists, Leg Raises',
        },
        {
          'dayName': 'Day 3 - Back',
          'exercises': 'Pull-Ups, Rows, Shoulder Press',
        },
        {
          'dayName': 'Day 4 - Leg Day',
          'exercises': 'Squats, Lunges, Leg Curls, Calf Raises',
        },
        // Add more days here
      ],
    },
    // Add more templates here
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Templates'),
        backgroundColor: theme_green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildStartEmptyWorkoutButton(),
            SizedBox(height: 16),
            buildTemplatesHeader(),
            SizedBox(height: 16),
            Expanded(
              child: buildTemplateList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStartEmptyWorkoutButton() {
    return GestureDetector(
      onTap: () {
        // TODO: Implement the functionality for starting an empty workout
      },
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
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

//   onPressed: () {
//   print('Icon Clicked');
//   Navigator.push(
//   context,
//   MaterialPageRoute(
//   builder: (context) => startTraining(), // This is your Templates page widget
//   ),
//   );
// },

  Widget buildTemplatesHeader() {
    return Row(
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
            backgroundColor: theme_green,
          ),
        ),
      ],
    );
  }

  Widget buildTemplateList() {
    return ListView.builder(
      itemCount: templates.length,
      itemBuilder: (context, index) {
        final template = templates[index];
        return buildTemplateCard(template);
      },
    );
  }
  Widget buildTemplateCard(Map<String, dynamic> template) {
    bool isTemplateAdded = true; // Keep track of whether the template is added

    return Card(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                Container(
                  height: 80, // Set a fixed height for the exercise list
                  child: ListView(
                    scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                    children: (template['days'] as List).map<Widget>((day) {
                      return Card(
                        child: Container(
                          width: 200, // Set a fixed width for the day card
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                day['dayName'] as String,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal, // Enable horizontal scrolling for exercises
                                child: Text(
                                  day['exercises'] as String,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8, // Adjust the top position as needed
            right: 8, // Adjust the right position as needed
            child: GestureDetector(
              onTap: () {
                // Toggle the template's state (added or not)
                isTemplateAdded = !isTemplateAdded;
                // TODO: Implement functionality to add or remove the template
              },
              child: Icon(
                isTemplateAdded ? Icons.check_box : Icons.check_box_outline_blank,
                size: 24,
                color: isTemplateAdded ? theme_green : Colors.grey, // Change the colors as needed
              ),
            ),
          ),
        ],
      ),
    );
  }





  Widget buildDayCard(Map<String, dynamic> day) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day['dayName'] as String,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(day['exercises'] as String),
          ],
        ),
      ),
    );
  }
}
