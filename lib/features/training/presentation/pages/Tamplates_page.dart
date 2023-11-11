import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/training/domain/entities/Template.dart';
import 'package:samla_app/features/training/presentation/cubit/Templates/template_cubit.dart';
import 'package:samla_app/features/training/training_di.dart' as di;

import 'new_tamplate_page.dart';

class TemplatesPage extends StatefulWidget {
  TemplatesPage({Key? key}) : super(key: key);

  @override
  _TemplatesPageState createState() => _TemplatesPageState();
}

class _TemplatesPageState extends State<TemplatesPage> {
  final cubit = TemplateCubit(di.sl.get());

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

  Map<String, bool> addedTemplates = {};

  @override
  void initState() {
    super.initState();
    // Initialize the addedTemplates map based on your templates list
    for (var template in templates) {
      addedTemplates[template['templateName']] = false;
    }
  }

  void showExercisesDialog(String dayName, String exercises) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(13),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(dayName,
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 20.0),
                SingleChildScrollView(
                  child: ListBody(
                    children: exercises.split(', ').map((exercise) {
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Image.network(
                              'https://source.unsplash.com/featured/?gym',
                              // Replace with your exercise image link
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            exercise, // The name of the exercise
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.info_outline),
                            onPressed: () {
                              // The functionality for showing exercise details goes here
                              _showExerciseDetails(context,
                                  exercise); // Make sure to define this method to show details
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20.0),
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showExerciseDetails(BuildContext context, String exercise) {
    // Implement your exercise details presentation logic here
  }

  ////////////////////////////  ////////////////////////////  ////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Workout Templates",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              /*
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NewMeal(),
                ),
              );

               */
            },
          ),
        ],
        flexibleSpace: AnimateGradient(
          primaryBegin: Alignment.topLeft,
          primaryEnd: Alignment.bottomLeft,
          secondaryBegin: Alignment.bottomRight,
          secondaryEnd: Alignment.topLeft,
          primaryColors: [
            theme_green,
            Colors.blueAccent,
          ],
          secondaryColors: [
            theme_green,
            const Color.fromARGB(255, 120, 90, 255)
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //buildStartEmptyWorkoutButton(),
            SizedBox(height: 16),
            //buildTemplatesHeader(context),
            SizedBox(height: 16),

            //Expanded(child: buildTemplateList(),),
            Expanded(child: buildBlocBuilder()),
          ],
        ),
      ),
    );
  }

  ////////////////////////////  ////////////////////////////  ////////////////////////////  ////////////////////////////

  Widget buildStartEmptyWorkoutButton() {
    return GestureDetector(
      onTap: () {
        // Implement the functionality for starting an empty workout
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: theme_green, width: 2),
          // Define your theme_green color in your theme
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Start Empty Workout',
              style: TextStyle(
                color: theme_green,
                // Define your theme_green color in your theme
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTemplatesHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Templates',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NewTemplatePage()), // Make sure you have NewTemplatePage in your project
            );
          },
          child: Text('+ Add Template'),
          style: ElevatedButton.styleFrom(
            primary: theme_green, // Define your theme_green color in your theme
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
    String templateName = template['templateName'];
    bool isTemplateAdded = addedTemplates[templateName] ?? false;

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
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: (template['days'] as List).map<Widget>((day) {
                      return InkWell(
                        onTap: () => showExercisesDialog(
                          day['dayName'] as String,
                          day['exercises'] as String,
                        ),
                        child: buildDayCard(day),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              onPressed: () {
                setState(() {
                  addedTemplates[templateName] = !isTemplateAdded;
                });
              },
              icon: Icon(
                isTemplateAdded ? Icons.toggle_on : Icons.toggle_off,
                size: 40,
                color: isTemplateAdded ? theme_green : Colors.grey,
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

  BlocBuilder<TemplateCubit, TemplateState> buildBlocBuilder() {
    cubit.getAllTemplates();
    return BlocBuilder<TemplateCubit, TemplateState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is TemplateLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: theme_green,
              backgroundColor: theme_pink,
            ),
          );
        } else if (state is TemplateLoaded) {
          return ListView.builder(
            itemCount: state.templates.length,
            itemBuilder: (context, index) {
              final template = state.templates[index];
              return _buildTemplateCard(template);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildTemplateCard(Template template) {
    String templateName = template.name;
    bool isTemplateAdded = addedTemplates[templateName] ?? false;

    return Card(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  template.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              onPressed: () {
                setState(() {
                  addedTemplates[templateName] = !isTemplateAdded;
                });
              },
              icon: Icon(
                isTemplateAdded ? Icons.toggle_on : Icons.toggle_off,
                size: 40,
                color: isTemplateAdded ? theme_green : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
