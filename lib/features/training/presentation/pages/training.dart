import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samla_app/features/training/presentation/cubit/exercise_cubit.dart';
import 'package:samla_app/features/training/presentation/pages/startTrainig.dart';
import 'package:samla_app/features/training/training_di.dart' as di;
import 'package:samla_app/config/themes/common_styles.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({Key? key}) : super(key: key);

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  final _controller = PageController();
  double _currentPage = 0;
  late ExerciseCubit exerciseCubit;
  final getIt = GetIt.instance;
  @override
  void initState() {
    super.initState();
    di.TrainingInit(); // Initialize the training module
    exerciseCubit = getIt<ExerciseCubit>();
    exerciseCubit.fetchExercises();

    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    exerciseCubit.close(); // Close the cubit when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseCubit, ExerciseState>(
      bloc: exerciseCubit,
      builder: (context, state) {
        if (state.isLoading) {
          return CircularProgressIndicator();
        } else // Inside the BlocBuilder in the build method
        if (state.exercises.isNotEmpty) {
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: state
                      .exercises.length, // Use the length of state.exercises
                  itemBuilder: (BuildContext context, int index) {
                    var currentExercise =
                        state.exercises[index]; // Current exercise object

                    // Build the content for the current exercise
                    return Container(
                      width: MediaQuery.of(context).size.width - 40,
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.all(16),
                      decoration:
                          primary_decoration, // Ensure this is defined in your project
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            currentExercise
                                .name, // Use the name from the current exercise
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          // more widgets that use properties of currentExercise

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    theme_green, // Ensure theme_green is defined and accessible
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
                                        startTraining(), // Navigate to the start training page
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
              DotsIndicator(
                dotsCount:
                    state.exercises.length, // Use the length of state.exercises
                position: _currentPage
                    .round(), // This should be the current page index
                decorator: DotsDecorator(
                  activeColor: theme_green, // Use your theme color here
                ),
              ),
              SizedBox(height: 16), // For spacing
            ],
          );
        } else if (state.error.isNotEmpty) {
          // Error handling
          return Text('Error: ${state.error}');
        } else {
          // No exercises found
          return Text('No exercises found.');
        }
      },
    );
  }
}
