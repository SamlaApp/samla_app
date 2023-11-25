import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:samla_app/features/training/presentation/cubit/History/history_cubit.dart';
import '../../../../config/themes/new_style.dart';
import '../../domain/entities/ExerciseLibrary.dart';
import '../widgets/startTraining/ExerciseScrollRow.dart';
import '../widgets/startTraining/progressSection.dart';
import '../widgets/startTraining/SelectedExerciseDisplay.dart';
import 'package:samla_app/features/training/training_di.dart' as di;

class StartTrainingNew extends StatefulWidget {
  final String dayName;
  final int dayIndex;
  final List<ExerciseLibrary> exercises;

  StartTrainingNew({
    super.key,
    required this.dayName,
    required this.dayIndex,
    required this.exercises,
  });

  @override
  _StartTrainingNewState createState() => _StartTrainingNewState();
}

class _StartTrainingNewState extends State<StartTrainingNew> {
  late ExerciseLibrary selectedExercise;
  final baseURL = 'https://samla.mohsowa.com/api/training/image/';
  TextEditingController kilogramsController = TextEditingController();
  TextEditingController repeatsController = TextEditingController();
  final historyCubit = di.sl.get<HistoryCubit>();


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.exercises.isNotEmpty) {
      selectedExercise = widget.exercises[0];
    }
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

  void selectNextExercise() {
    int currentIndex = widget.exercises.indexOf(selectedExercise);
    if (currentIndex < widget.exercises.length - 1) {
      setState(() {
        selectedExercise = widget.exercises[currentIndex + 1];
        loadHistoryForExercise();
      });
    } else {
      // If it's the last exercise, show a thank you dialog
      _showThankYouDialog();
    }
  }

  void _showThankYouDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Test Dialog"),
          content: Text("This is a test."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dayName.toUpperCase(),
            style: const TextStyle(
                color: white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                fontFamily: 'Cairo')),
        flexibleSpace: AnimateGradient(
          primaryBegin: Alignment.topLeft,
          primaryEnd: Alignment.bottomLeft,
          secondaryBegin: Alignment.bottomRight,
          secondaryEnd: Alignment.topLeft,
          primaryColors: const [
            themeOrange,
            themePink,
          ],
          secondaryColors: const [
            themePink,
            themeRed,
          ],
        ),
        iconTheme: const IconThemeData(color: white),
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
              selectedExercise: selectedExercise,
              onAllSetsCompleted:
              selectNextExercise, // Pass the new method as a callback
            ),
            // ## exercise scroll row
            ExerciseScrollRow(
              exercises: widget.exercises,
              selectedExercise: selectedExercise,
              onExerciseSelect: (ExerciseLibrary exercise) {
                setState(() {
                  selectedExercise = exercise;
                  loadHistoryForExercise();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
