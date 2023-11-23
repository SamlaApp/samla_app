import 'dart:async';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:io/ansi.dart';

import '../../../../config/themes/common_styles.dart';
import '../../domain/entities/ExerciseDay.dart';
import '../../domain/entities/ExerciseLibrary.dart';
import '../widgets/CountDownTimer.dart';
import '../widgets/ExerciseInfoStartPage.dart';

// import '../widgets/exercise_numbers.dart';
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
  late int countdownValue; // Initial countdown value in seconds
  // Initial countdown value in seconds
  late Timer? countdownTimer; // Timer for countdown
  int totalSets = 3;
  int finishedSets = 0;
  late ExerciseLibrary selectedExercise;
  final baseURL = 'https://samla.mohsowa.com/api/training/image/';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ExerciseDay? setsnum;

  TextEditingController kilogramsController = TextEditingController();
  TextEditingController repeatsController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free up resources when the widget is disposed
    kilogramsController.dispose();
    repeatsController.dispose();
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    print('sff$setsnum');
    super.initState();
    if (widget.exercises.isNotEmpty) {
      selectedExercise = widget.exercises[0];
      finishedSets = 0;
      totalSets = 3;
      countdownTimer = null;
      countdownValue = 30;
    }
  }

  String formatTime(int seconds) {
    // Format seconds as MM:SS
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void startCountdown() {
    countdownTimer?.cancel(); // Cancel the timer if it's not null
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countdownValue > 0) {
          countdownValue--;
        } else {
          // Countdown finished, reset the value and cancel the timer
          countdownValue = 30;
          countdownTimer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Training - Day ${widget.dayName} / ${_getDayNameFromIndex(widget.dayIndex)}'),
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
                finishedSets = 0;
                totalSets = 3;
                countdownValue = 30;
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
                  buildNumber(context),
                  // SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 5, 0),
                              height: 50,
                              decoration: textField_decoration,
                              child: TextFormField(
                                controller: kilogramsController,
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
                                keyboardType: TextInputType.number,
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return value;
                                //   }
                                //   return null;
                                // },
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
                              child: TextFormField(
                                controller: repeatsController,
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
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),

                          Container(
                            child: TextButton(
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                // Manually trigger validation
                                if (_formKey.currentState != null) {
                                  _formKey.currentState!.validate();
                                }

                                // Check if the kilograms field is empty
                                if (kilogramsController.text.isEmpty) {
                                  // Show a SnackBar with the validation message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please enter kilograms'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    startCountdown();
                                    countdownValue = 30;
                                    if (finishedSets < totalSets)
                                      finishedSets++;
                                    kilogramsController.clear();
                                    repeatsController.clear();
                                    // if (!countdownTimer.isActive) {
                                    //   countdownTimer.cancel();
                                    // }

                                    if (finishedSets == totalSets) {
                                      selectedExercise = widget.exercises[widget
                                              .exercises
                                              .indexOf(selectedExercise) +
                                          1];
                                      finishedSets = 0;
                                    }
                                  });
                                }
                              },
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: theme_green,
                            ),
                          )
                        ],
                      )
                    ]),
                  ),
                  Divider(),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        totalSets++;
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

  Widget buildNumber(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
      decoration: primary_decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildButton(
            context,
            '10',
            'Repeats',
          ),
          buildButton(
            context,
            formatTime(countdownValue),
            'Rest',
          ),
          buildButton(
            context,
            '${finishedSets}/${totalSets}',
            'Sets',
          )
        ],
      ),
    );
  }

  Widget buildButton(BuildContext context, String numbers, String text) =>
      MaterialButton(
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              numbers,
              style: TextStyle(fontSize: 18, color: theme_green),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      );
}
