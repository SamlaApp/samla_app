import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/training/presentation/cubit/Templates/template_cubit.dart';
import 'package:samla_app/features/training/presentation/pages/startTrainig.dart';
import '../../../../config/themes/common_styles.dart';
import 'Tamplates_page.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:samla_app/features/training/training_di.dart' as di;

class TrainingPage extends StatefulWidget {
  TrainingPage({Key? key}) : super(key: key);

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  final _controller = PageController();
  double _currentPage = 0;

  late TemplateCubit cubit;

  @override
  void initState() {
    super.initState();

    di.trainingInit(); // Initialize the training module
    cubit = di.sl<TemplateCubit>(); // Get the cubit instance

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          _activeTemplate(),
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
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: primary_decoration,
                    // ensure this is defined in your project
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          dayRoutine,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...exercises, // Insert the list of exercises
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme_green,
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
                            child: const Text('Start Now'),
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
          const SizedBox(height: 16), // for spacing
        ],
      ),
    );
  }

  BlocBuilder<TemplateCubit, TemplateState> _activeTemplate() {
    cubit.activeTemplate();
    return BlocBuilder<TemplateCubit, TemplateState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is TemplateLoadingState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                color: theme_green,
                backgroundColor: theme_pink,
              ),
            ),
          );
        } else if (state is ActiveTemplateLoaded) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [theme_red, theme_darkblue],
                  tileMode: TileMode.clamp,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                backgroundBlendMode: BlendMode.darken,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.template.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const TemplatesPage(), // This is your Templates page widget
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit, color: Colors.white)
                  ),
                ],
              ),
            ),
          );
        } else if (state is TemplateEmptyState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No templates found'),
            ),
          );
        } else if (state is TemplateErrorState) {
          return Center(
            child: Text(state.message),
          );
        }
        return const SizedBox.shrink();
      },
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
        padding: const EdgeInsets.all(8.0),
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

            const SizedBox(width: 16), // spacing between the image and the texts

            // Right side texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16, // for larger text
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8), // spacing between title and subtitle
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 13), // for smaller text
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
                  child: const Icon(
                    Icons.more_vert_outlined,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 18),
                GestureDetector(
                  onTap: () {
                    print('drag Clicked');
                  },
                  child: const Icon(
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
