import 'dart:async';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/common_styles.dart';
import '../../domain/entities/ExerciseLibrary.dart';
import '../widgets/CountDownTimer.dart';
import '../widgets/ExerciseInfoStartPage.dart';
import '../widgets/exercise_numbers.dart';
import '../widgets/exercise_tile.dart';

// import 'package:samla_app/features/training/presentation/widgets/exercise_numbers.dart'
class StartTrainingNew extends StatefulWidget {
  final String dayName;
  final int dayIndex;
  final List<ExerciseLibrary> exercises;

  StartTrainingNew({
    required this.dayName,
    required this.dayIndex,
    required this.exercises,
  });

  @override
  _StartTrainingNewState createState() => _StartTrainingNewState();
}

class _StartTrainingNewState extends State<StartTrainingNew>
    with TickerProviderStateMixin {
  int countdownValue = 30; // Initial countdown value in seconds
  late Timer _timer;
  late ExerciseLibrary selectedExercise;

  final baseURL = 'https://samla.mohsowa.com/api/training/image/';

  @override
  void initState() {
    super.initState();
    if (widget.exercises.isNotEmpty) {
      selectedExercise = widget.exercises[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Training - Day ${widget.dayName} / ${_getDayNameFromIndex(
                widget.dayIndex)}'),
        flexibleSpace: AnimateGradient(
          primaryBegin: Alignment.topLeft,
          primaryEnd: Alignment.bottomLeft,
          secondaryBegin: Alignment.bottomRight,
          secondaryEnd: Alignment.topLeft,
          primaryColors: [
            theme_orange,
            theme_pink,
          ],
          secondaryColors: [
            theme_pink,
            theme_red,
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSelectedExerciseDisplay(),
            _buildExerciseScrollRow(),
            // info section here
            // ExerciseInfoSection(selectedExercise: selectedExercise), // Pass selectedExercise
            // _buildProgressSection(),
            buildProgressSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedExerciseDisplay() {
    return Container(
      decoration: primary_decoration,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ExerciseInfoStartPage(
            name: selectedExercise.name,
            gifUrl: baseURL + selectedExercise.gifUrl,
            bodyPart: selectedExercise.bodyPart,
            equipment: selectedExercise.equipment,
            target: selectedExercise.target,
            secondaryMuscles: selectedExercise.secondaryMuscles,
            instructions: selectedExercise.instructions,
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseScrollRow() {
    return Container(
      decoration: primary_decoration.copyWith(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      height: 80, // Adjust as needed
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.exercises.length,
        itemBuilder: (context, index) {
          final exercise = widget.exercises[index];
          bool isSelected = selectedExercise == exercise;

          return InkWell(
            onTap: () {
              setState(() {
                selectedExercise = exercise;
              });
            },
            child: Container(
              width: 65,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey[300]!,
                  // Blue border for selected item
                  width: isSelected ? 3 : 1, // Thicker border for selected item
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                baseURL + exercise.gifUrl,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
          );
        },
      ),
    );
  }

  String _getDayNameFromIndex(int index) {
    switch (index) {
      case 0:
        return "Sunday";
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      default:
        return "Unknown Day";
    }
  }

  Widget buildProgressSection() {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        gradient: LinearGradient(
          colors: [theme_pink, theme_darkblue],
          tileMode: TileMode.clamp,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
                  ExerciseNumbersWidget(),
                  // SizedBox(height: 16),
                  Column(children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 5, 0),
                            height: 50,
                            decoration: textField_decoration,
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Kilograms',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  // Customize focused border color
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  // Customize enabled border color
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        // Spacer between the text fields
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 20, 0),
                            height: 50,
                            decoration: textField_decoration,
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Repeats',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  // Customize focused border color
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  // Customize enabled border color
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // color: theme_green,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ExerciseNumbersWidget();
                            },
                            icon: Icon(
                              Icons.done_outlined,
                              color: Colors.white,
                            ),
                            label: Text('Press me'),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: theme_green,
                          ),
                        )
                      ],
                    )
                  ]),
                  Divider(),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        // sets.add();
                      });
                    },
                    icon: Icon(Icons.add, size: 16.0, color: theme_green),
                    label: Text("Add Set",
                        style: TextStyle(
                          fontSize: 14,
                          color: theme_green,
                        )),
                    style: ButtonStyle(
                      // backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
