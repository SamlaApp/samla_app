import 'package:flutter/material.dart';
import 'package:samla_app/features/training/presentation/pages/startTrainig.dart';
import '../../../../config/themes/common_styles.dart';
import 'Tamplates_page.dart';
import 'package:dots_indicator/dots_indicator.dart';

class TrainingPage extends StatefulWidget {
  TrainingPage({Key? key}) : super(key: key);

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  final _controller = PageController();
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            height: 67,
            padding: const EdgeInsets.all(13),
            margin: EdgeInsets.all(16),
            decoration: primary_decoration,
            // ensure this is defined in your project
            child: Row(
              children: [
                Text(
                  'KFUPM Gym Template',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    print('Icon Clicked');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TemplatesPage(), // This is your Templates page widget
                      ),
                    );
                  },
                  child: Icon(
                    Icons.edit,
                    size: 30,
                  ),
                )
              ],
            ),
          ),

          Expanded(
            child: Container(
              // color: theme_darkblue,
              child: PageView.builder(
                controller: _controller,
                itemCount: 3, // specify the number of days
                itemBuilder: (BuildContext context, int index) {
                  // Determine the day and routine based on the index
                  String dayRoutine = '';
                  List<Widget> exercises = [];
                  switch (index) {
                    case 0:
                      dayRoutine = 'Day 1 - Pull Routine';
                      exercises = [
                        ExerciseTile(
                          imageUrl: 'https://source.unsplash.com/featured/?gym',
                          title: 'Pull-Ups',
                          subtitle: '3 sets of 10 reps',
                        ),
                        ExerciseTile(
                          imageUrl: 'https://source.unsplash.com/featured/?gym',
                          title: 'Pull-Ups',
                          subtitle: '3 sets of 10 reps',
                        ),
                        ExerciseTile(
                          imageUrl: 'https://source.unsplash.com/featured/?gym',
                          title: 'Pull-Ups',
                          subtitle: '3 sets of 10 reps',
                        ),
                        ExerciseTile(
                          imageUrl: 'https://source.unsplash.com/featured/?gym',
                          title: 'Pull-Ups',
                          subtitle: '3 sets of 10 reps',
                        ),
                        // Add more ExerciseTile widgets specific to Day 1
                      ];
                      break;
                    case 1:
                      dayRoutine = 'Day 2 - Push Routine';
                      exercises = [
                        ExerciseTile(
                          imageUrl: 'https://source.unsplash.com/featured/?gym',
                          title: 'Push-Ups',
                          subtitle: '4 sets of 10 reps',
                        ),
                        ExerciseTile(
                          imageUrl: 'https://source.unsplash.com/featured/?gym',
                          title: 'Push-Ups',
                          subtitle: '4 sets of 10 reps',
                        ),
                        ExerciseTile(
                          imageUrl: 'https://source.unsplash.com/featured/?gym',
                          title: 'Push-Ups',
                          subtitle: '4 sets of 10 reps',
                        ),
                        ExerciseTile(
                          imageUrl: 'https://source.unsplash.com/featured/?gym',
                          title: 'Push-Ups',
                          subtitle: '4 sets of 10 reps',
                        ),
                        // Add more ExerciseTile widgets specific to Day 2
                      ];
                      break;
                    case 2:
                      dayRoutine = 'Day 3 - Legs Routine';
                      exercises = [
                        ExerciseTile(
                          imageUrl: 'https://source.unsplash.com/featured/?gym',
                          title: 'Squats',
                          subtitle: '5 sets of 8 reps',
                        ),
                        ExerciseTile(
                          imageUrl: 'https://source.unsplash.com/featured/?gym',
                          title: 'Squats',
                          subtitle: '5 sets of 8 reps',
                        ),
                        ExerciseTile(
                          imageUrl: 'https://source.unsplash.com/featured/?gym',
                          title: 'Squats',
                          subtitle: '5 sets of 8 reps',
                        ),
                        // Add more ExerciseTile widgets specific to Day 3
                      ];
                      break;
                    // Add more cases for more days
                  }

                  // Build the content for the current day
                  return Container(
                    width: MediaQuery.of(context).size.width - 40,
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(16),
                    decoration: primary_decoration,
                    // ensure this is defined in your project
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          dayRoutine,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        ...exercises, // Insert the list of exercises
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: theme_green,
                              // ensure theme_green is defined and accessible
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              print('Start Clicked');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      startTraining(), // This is your Templates page widget
                                ),
                              );
                            },
                            child: Text('Start Now'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          DotsIndicator(
            dotsCount: 3,
            // the number of dots should match the number of days/pages
            position: _currentPage.round(),
            // this should be the current page index
            decorator: DotsDecorator(
              activeColor: theme_green, // use your theme color here
            ),
          ),
          SizedBox(height: 16), // for spacing
        ],
      ),
    );
  }
}

class ExerciseTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  ExerciseTile({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Left side image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              // same as Card borderRadius
              child: Image.network(
                imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 16), // spacing between the image and the texts

            // Right side texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16, // for larger text
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8), // spacing between title and subtitle
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13), // for smaller text
                  ),
                ],
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    print('more Clicked');
                  },
                  child: Icon(
                    Icons.more_vert_outlined,
                    size: 20,
                  ),
                ),
                SizedBox(height: 18),
                GestureDetector(
                  onTap: () {
                    print('drag Clicked');
                  },
                  child: Icon(
                    Icons.drag_handle_rounded,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//     // Quick Start and Routines section
//     ExpandableBox(
//       title: "Empty workout & Routines",
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SectionTitle(title: 'Start Empty Workout'),
//           SizedBox(height: 8),
//           StartWorkoutButton(),
//           SizedBox(height: 16),
//           SectionTitle(title: 'Routines'),
//           SizedBox(height: 8),
//           RoutineButtons(),
//         ],
//       ),
//     ),

// TransparentBox(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// SectionTitle(title: 'My Routines'),
// SizedBox(height: 8),
// RoutineCard(title: 'Pull Routine', exercises: [
// Exercise(name: 'Pull-Ups'),
// Exercise(name: 'Chin-Ups'),
// Exercise(name: 'Deadlifts'),
// ]),
// SizedBox(height: 8),
// RoutineCard(title: 'Push Routine', exercises: [
// Exercise(name: 'Push-Ups'),
// Exercise(name: 'Bench Press'),
// Exercise(name: 'Dips'),
// ]),
// ],
// ),
// ),
