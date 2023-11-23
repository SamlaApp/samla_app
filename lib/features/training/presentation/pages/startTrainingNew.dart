import 'dart:async';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseHistory.dart';
import 'package:samla_app/features/training/presentation/cubit/History/history_cubit.dart';

import '../../../../config/themes/common_styles.dart';
import '../../domain/entities/ExerciseLibrary.dart';
import '../widgets/CountDownTimer.dart';
import '../widgets/ExerciseInfoStartPage.dart';

// import '../widgets/exercise_numbers.dart';
import '../widgets/exercise_tile.dart';
import 'ExDay.dart';
import 'package:samla_app/features/training/training_di.dart' as di;

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

  int totalSets = 3;
  int finishedSets = 0;

  late ExerciseLibrary selectedExercise;

  final baseURL = 'https://samla.mohsowa.com/api/training/image/';

  final historyCubit = di.sl.get<HistoryCubit>();

  @override
  void initState() {
    super.initState();

    historyCubit.getHistory(id: widget.exercises[0].id!);

    if (widget.exercises.isNotEmpty) {
      selectedExercise = widget.exercises[0];
      countdownValue = 0;
      finishedSets = 0;
    }
  }


  void setHistory() {
    historyCubit.addHistory(
      set: 1,
      duration: 1,
      repetitions: 1,
      weight: 1,
      distance: 1,
      notes: 'test',
      exercise_library_id: 664,
    );
  }


  BlocBuilder<HistoryCubit, HistoryState> buildHistory() {
    return BlocBuilder<HistoryCubit, HistoryState>(
      bloc: historyCubit,
      builder: (context, state) {
        if (state is HistoryLoadingState) {
          return Center(child: CircularProgressIndicator(
            color: theme_green,
            backgroundColor: theme_pink,
          ));
        } else if (state is HistoryLoadedState) {
          return Column(
            children: [
              for (var history in state.history)
                Text(
                  history.notes!,
                  style: TextStyle(color: Colors.grey),
                ),
            ],
          );
        } else if (state is HistoryErrorState) {
          return Center(child: Text(state.message));
        } else if (state is HistoryEmptyState) {
          return Center(child: Text('No history found'));
        } else if (state is NewHistoryLoadedState) {
          historyCubit.getHistory(id: widget.exercises[0].id!);
          return Center(child: CircularProgressIndicator(
            color: theme_green,
            backgroundColor: theme_pink,
          ));
        } else {
          return Container();
        }
      },
    );

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
            // info section here
            // ExerciseInfoSection(selectedExercise: selectedExercise), // Pass selectedExercise
            // _buildProgressSection(),
            buildProgressSection(),

            buildHistory(),

            ElevatedButton(
                onPressed: () {
                  setHistory();
                },
                child: Text('Add History')),


            IconButton(
              icon: Icon(Icons.history),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ExerciseDayDialog(
                      exerciseHistory: [
                        ExerciseDay(
                          exerciseLibraryId: 1,
                          sets: 3,
                          repetitions: 12,
                          weight: 50.0,
                          distance: 2.5,
                          duration: 30,
                          notes: 'Completed with ease',
                        ),
                        ExerciseDay(
                          exerciseLibraryId: 1,
                          sets: 3,
                          repetitions: 12,
                          weight: 50.0,
                          distance: 2.5,
                          duration: 30,
                          notes: 'Completed with ease',
                        ),
                        ExerciseDay(
                          exerciseLibraryId: 1,
                          sets: 3,
                          repetitions: 12,
                          weight: 50.0,
                          distance: 2.5,
                          duration: 30,
                          notes: 'Completed with ease',
                        ),
                      ],
                    );
                  },
                );
              },
            )
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
                              setState(() {
                                if (finishedSets < totalSets) {
                                  finishedSets++; // Increment finishedSets
                                }
                              });
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
            '00:00',
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
