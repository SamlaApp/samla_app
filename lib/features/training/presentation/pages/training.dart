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
                        ExerciseTiles(
                          exercise: ExercisesItem(
                            name: 'Push Up',
                            bodyPart: 'Chest',
                            equipment: 'None',
                            gifUrl: 'https://source.unsplash.com/featured/?gym',
                            target: 'Chest muscles',
                            instructions: 'Keep your back straight and lower your body.',
                            secondaryMuscles: ['Triceps', 'Shoulders'],
                          ),

                        ),
                        // Add more ExerciseTile widgets specific to Day 1
                        ExerciseTiles(exercise:
                        ExercisesItem(
                          name:'Pull Up',
                          bodyPart: 'Back',
                          equipment: 'Pull Up Bar',
                          gifUrl: 'https://source.unsplash.com/featured/?gym',
                          target: 'Back muscles',
                          instructions: 'Keep your back straight and pull your body up.',
                          secondaryMuscles: ['Biceps', 'Forearms'],
                        )
                        )
                      ];
                      break;
                    case 1:
                      dayRoutine = 'Day 2 - Push Routine';
                      exercises = [
                        ExerciseTiles(
                          exercise: ExercisesItem(
                            name: 'Push Up',
                            bodyPart: 'Chest',
                            equipment: 'None',
                            gifUrl: 'https://source.unsplash.com/featured/?gym',
                            target: 'Chest muscles',
                            instructions: 'Keep your back straight and lower your body.',
                            secondaryMuscles: ['Triceps', 'Shoulders'],
                          ),
                        ),
                        // Add more ExerciseTile widgets specific to Day 2
                      ];
                      break;
                    case 2:
                      dayRoutine = 'Day 3 - Legs Routine';
                      exercises = [



                        // Add more ExerciseTile widgets specific to Day 3
                  // final String name;
                  // final String bodyPart;
                  // final String equipment;
                  // final String gifUrl;
                  // final String target;
                  // final String instructions;
                  // final List<String> secondaryMuscles;

                        ExerciseTiles(
                          exercise: ExercisesItem(
                            name: 'Push Up',
                            bodyPart: 'Chest',
                            equipment: 'None',
                            gifUrl: 'https://source.unsplash.com/featured/?gym',
                            target: 'Chest muscles',
                            instructions: 'Keep your back straight and lower your body.',
                            secondaryMuscles: ['Triceps', 'Shoulders'],
                          ),
                        ),
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
                        _buildGradientBorderButton(context),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // _buildGradientBorderButton(),
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
          } else {
            return const SizedBox.shrink();
          }
        }
    );
  }
}





Widget _buildGradientBorderButton(BuildContext context) {
  return InkWell(
    onTap: () {
      print('Start Clicked');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => startTraining(), // This is your Start Training page widget
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(7.0),
      child: Container(
        padding: EdgeInsets.all(4), // Padding for the gradient border
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11), // slightly larger radius for the border
          gradient: LinearGradient(
            colors: [theme_darkblue, Colors.red],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color: Colors.white, // White background
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [theme_darkblue, Colors.red],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds);
                },
                child: Text(
                  'Start Now',
                  style: TextStyle(
                    color: Colors.white, // This color is important to make gradient visible
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(), // Use Spacer for even spacing
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [theme_darkblue, Colors.red],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class ExercisesItem {
  final String name;
  final String bodyPart;
  final String equipment;
  final String gifUrl;
  final String target;
  final String instructions;
  final List<String> secondaryMuscles;

  ExercisesItem({
    required this.name,
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.target,
    required this.instructions,
    required this.secondaryMuscles,
  });
}




class ExerciseTiles extends StatelessWidget {
  final ExercisesItem exercise;

  ExerciseTiles({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showExerciseDetails(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Adjust margins
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: theme_red.withOpacity(0.5), // Light border color
            width: 1.0, // Border width
          ),
        ),
        child: Row(
          children: <Widget>[

            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(exercise.gifUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Content on the right with smaller padding
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6.0), // Reduce padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      exercise.name,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Adjust font size
                      maxLines: 2, // Limit to 2 lines
                      overflow: TextOverflow.ellipsis, // Ellipsis for long names
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Tap for details',
                      style: TextStyle(fontSize: 12, color: Colors.grey), // Adjust font size
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExerciseDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
        backgroundColor: Colors.white,
          title: Text(
            exercise.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Adjust font size
          ),
          content: Container(
            width: 300, // Adjust width
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    //center image
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          exercise.gifUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  //space in between
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBorderContainer('bodyPart', exercise.bodyPart),

                    CustomBorderContainer('Equipment', exercise.equipment),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBorderContainer('Target', exercise.target),
                    CustomBorderContainer('Secondary Muscles', exercise.secondaryMuscles.join(', ')),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomBorderContainer('Instructions', exercise.instructions),
                  ],
                ), // Custom widget
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: theme_green, // Change background color
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close', style: TextStyle(fontSize: 14,color: Colors.white)), // Adjust font size
            ),
          ],
        );
      },
    );
  }



  Widget CustomBorderContainer(String label, String value) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: Container(
            width: 140, // Decreased width
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12), // Smaller padding
            decoration: BoxDecoration(
              border: Border.all(color: theme_red, width: 1.5), // Smaller border width
              borderRadius: BorderRadius.circular(6), // Smaller border radius
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 12, // Smaller font size
              ),
            ),
          ),
        ),
        Positioned(
          top: -2,
          left: 3, // Adjusted left position
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8), // Smaller border radius
            child: Container(
              color: theme_red,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1), // Smaller padding
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12, // Smaller font size
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


