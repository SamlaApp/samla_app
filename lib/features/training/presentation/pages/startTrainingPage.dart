import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:samla_app/features/training/presentation/cubit/History/history_cubit.dart';
import '../../../../config/themes/new_style.dart';
import '../../domain/entities/ExerciseLibrary.dart';
import '../widgets/startTraining/ExerciseScrollRow.dart';
import '../widgets/startTraining/progressSection.dart';
import '../widgets/startTraining/SelectedExerciseDisplay.dart';
import 'package:samla_app/features/training/training_di.dart' as di;

class StartTraining extends StatefulWidget {
  final String dayName;
  final int dayIndex;
  final List<ExerciseLibrary> exercises;

  const StartTraining({
    super.key,
    required this.dayName,
    required this.dayIndex,
    required this.exercises,
  });

  @override
  StartTrainingState createState() => StartTrainingState();
}

class StartTrainingState extends State<StartTraining>
    with TickerProviderStateMixin {
  late ExerciseLibrary selectedExercise;
  final baseURL = 'https://samla.mohsowa.com/api/training/image/';
  TextEditingController kilogramsController = TextEditingController();
  TextEditingController repeatsController = TextEditingController();
  final historyCubit = di.sl.get<HistoryCubit>();
  late AnimationController smallStarController1;
  late AnimationController largeStarController;
  late AnimationController smallStarController2;

  @override
  void initState() {
    super.initState();
    if (widget.exercises.isNotEmpty) {
      selectedExercise = widget.exercises[0];
    }

    smallStarController1 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    largeStarController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    smallStarController2 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    smallStarController1.dispose();
    largeStarController.dispose();
    smallStarController2.dispose();
    super.dispose();
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

  void selectNextExercise() async {
    int currentIndex = widget.exercises.indexOf(selectedExercise);
    if (currentIndex < widget.exercises.length - 1) {
      setState(() {
        selectedExercise = widget.exercises[currentIndex + 1];
        loadHistoryForExercise();
      });
    } else {
      print("Last exercise completed, showing dialog");
      bool? trainingCompleted = await _showThankYouDialog();
      print("Dialog closed with value: $trainingCompleted");
      if (trainingCompleted == true) {
        Navigator.of(context).pop(true);
      }
    }
  }

  Future<bool?> _showThankYouDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeTransition(
                    opacity: smallStarController1,
                    child: const Icon(Icons.star_rate,
                        size: 22, color: themeRed), // Smaller star
                  ),
                  FadeTransition(
                    opacity: largeStarController,
                    child: const Icon(Icons.star_rate,
                        size: 45, color: themeRed), // Larger star
                  ),
                  FadeTransition(
                    opacity: smallStarController2,
                    child: const Icon(Icons.star_rate,
                        size: 22, color: themeRed), // Smaller star
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Training Complete",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: const Text(
            "Congratulations! You've completed today's training session. Great job!",
            style: TextStyle(color: Colors.black87, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Close", style: TextStyle(color: Colors.blueAccent)),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
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
        backgroundColor: themeDarkBlue,
        iconTheme: const IconThemeData(color: white),
      ),
      body: Center(
        child: SingleChildScrollView(
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
              //_showThankYouDialog(), button to show the dialog
              // ElevatedButton(
              //     onPressed: () {
              //       _showThankYouDialog();
              //     },
              //     child: Text('set Dialog'))
            ],
          ),
        ),
      ),
    );
  }
}
