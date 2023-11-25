import 'dart:async';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samla_app/features/training/presentation/cubit/History/history_cubit.dart';
import '../../../../config/themes/new_style.dart';
import '../../domain/entities/ExerciseLibrary.dart';
import '../widgets/startTraninig/ExerciseScrollRow.dart';
import '../widgets/startTraninig/progressSection.dart';
import '../widgets/startTraninig/SelectedExerciseDisplay.dart';
import 'package:samla_app/features/training/training_di.dart' as di;

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

class _StartTrainingNewState extends State<StartTrainingNew> {
  late int countdownValue; // Initial countdown value in seconds
  late Timer? countdownTimer; // Timer for countdown
  int totalSets = 3;
  int finishedSets = 0;
  late ExerciseLibrary selectedExercise;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final baseURL = 'https://samla.mohsowa.com/api/training/image/';
  TextEditingController kilogramsController = TextEditingController();
  TextEditingController repeatsController = TextEditingController();
  final historyCubit = di.sl.get<HistoryCubit>();

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

  void setHistory() {
    historyCubit.addHistory(
      set: 2,
      duration: 22,
      repetitions: 1,
      weight: 1.5,
      distance: 1.45,
      notes: 'new note from me',
      exercise_library_id: selectedExercise.id!,
    );
    loadHistoryForExercise();
  }

  void loadHistoryForExercise() {
    historyCubit.getHistory(id: selectedExercise.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dayName.toUpperCase(),
            style: TextStyle(
                color: white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                fontFamily: 'Cairo')),
        flexibleSpace: AnimateGradient(
          primaryBegin: Alignment.topLeft,
          primaryEnd: Alignment.bottomLeft,
          secondaryBegin: Alignment.bottomRight,
          secondaryEnd: Alignment.topLeft,
          primaryColors: [
            themeOrange,
            themePink,
          ],
          secondaryColors: [
            themePink,
            themeRed,
          ],
        ),
        iconTheme: IconThemeData(color: white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ## selected exercise section
            SelectedExerciseDisplay(
              selectedExercise: selectedExercise,
              historyCubit: historyCubit,
            ),
            // buildProgressSection(),
            ProgressSection(
              totalSets: totalSets,
              finishedSets: finishedSets,
              updateTotalSets: (newTotalSets) =>
                  setState(() => totalSets = newTotalSets),
              selectedExercise: selectedExercise,
            ),
            // ## exercise scroll row
            ExerciseScrollRow(
              exercises: widget.exercises,
              selectedExercise: selectedExercise,
              onExerciseSelect: (ExerciseLibrary exercise) {
                setState(() {
                  selectedExercise = exercise;
                  finishedSets = 0;
                  totalSets = 3;
                  countdownValue = 30;
                  loadHistoryForExercise();
                });
              },
            ),
          ],
        ),
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
}
