import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:samla_app/features/training/presentation/cubit/History/history_cubit.dart';
import '../../../../config/themes/new_style.dart';
import '../../domain/entities/ExerciseLibrary.dart';
import '../widgets/startTraining/ExerciseScrollRow.dart';
import '../widgets/startTraining/customThanks.dart';
import '../widgets/startTraining/progressSection.dart';
import '../widgets/startTraining/SelectedExerciseDisplay.dart';
import 'package:samla_app/features/training/training_di.dart' as di;

class StartTraining extends StatefulWidget {
  final String dayName;
  final int dayIndex;
  final List<ExerciseLibrary> exercises;
  final String templateName;

  const StartTraining({
    super.key,
    required this.dayName,
    required this.dayIndex,
    required this.exercises,
    required this.templateName,
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
  int initialSets = 0;
  int wholeNumberWeight = 0;
  double fractionalWeight = 0.0;
  int initialReps = 0;
  int kilometers = 0;
  int meters = 0;

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

  void loadHistoryForExercise() async {
    await historyCubit.getHistory(id: selectedExercise.id!);
    historyCubit.stream.listen((state) {
      if (!mounted) return; // Check if the widget is still in the tree

      if (state is HistoryLoadedState && state.history.isNotEmpty) {
        var lastSet = state.history.last;
        setState(() {
          initialSets = lastSet.sets!;
          initialReps = lastSet.repetitions!;
          wholeNumberWeight = lastSet.weight!.truncate();
          fractionalWeight = lastSet.weight! - wholeNumberWeight;

          if (selectedExercise.bodyPart == 'cardio') {
            kilometers = lastSet.distance!.truncate();
            meters = ((lastSet.distance! - kilometers) * 1000).round();
          }
        });
      }
    });
  }

  void selectNextExercise() async {
    int currentIndex = widget.exercises.indexOf(selectedExercise);
    print("Current index: $currentIndex");
    if (currentIndex < widget.exercises.length - 1) {
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() {
        selectedExercise = widget.exercises[currentIndex + 1];
      });
      await Future.delayed(const Duration(seconds: 0));
      // Wait for the next frame to ensure the state is updated
      await Future.delayed(Duration.zero, () {
        loadHistoryForExercise();
      });
    } else {
      print("Last exercise completed, showing dialog");
      bool? trainingCompleted = await showThankYouDialog(context,
          smallStarController1, largeStarController, smallStarController2);
      print("Dialog closed with value: $trainingCompleted");
      if (trainingCompleted == true) {
        Navigator.of(context).pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.dayName.toUpperCase(),
          style: const TextStyle(
            color: white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            fontFamily: 'Cairo',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        flexibleSpace: AnimateGradient(
          primaryBegin: Alignment.topLeft,
          primaryEnd: Alignment.bottomLeft,
          secondaryBegin: Alignment.bottomRight,
          secondaryEnd: Alignment.topRight,
          primaryColors: const [themeDarkBlue, themeBlue],
          // Use your colors
          secondaryColors: const [themeDarkBlue, themeBlue],
          // Use your colors
          duration: const Duration(seconds: 3),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(children: [
                // ## selected exercise section
                SelectedExerciseDisplay(
                  selectedExercise: selectedExercise,
                  historyCubit: historyCubit,
                ),
                ProgressSection(
                  selectedExercise: selectedExercise,
                  selectNextExercise:
                      selectNextExercise, // Pass the new method as a callback
                  dayIndex: widget.dayIndex, // Pass the dayIndex here
                  templateName: widget.templateName,
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
                // showThankYouDialog(
                //           context,
                //           smallStarController1,
                //           largeStarController,
                //           smallStarController2
                //       );
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
