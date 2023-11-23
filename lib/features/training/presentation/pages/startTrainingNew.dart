import 'package:flutter/material.dart';

import '../../../../config/themes/common_styles.dart';
import '../../domain/entities/ExerciseLibrary.dart';
import '../widgets/ExerciseInfoStartPage.dart';
import '../widgets/exercise_tile.dart';

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

class _StartTrainingNewState extends State<StartTrainingNew> with TickerProviderStateMixin {
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
        title: Text('Training - Day ${widget.dayName} / ${_getDayNameFromIndex(widget.dayIndex)}'),
      ),
      body: Column(
        children: [
          _buildSelectedExerciseDisplay(),
          _buildExerciseScrollRow(),
          // info section here
          // ExerciseInfoSection(selectedExercise: selectedExercise), // Pass selectedExercise
         // _buildProgressSection(),
          buildProgressSection(),
        ],
      ),
    );
  }

  Widget _buildSelectedExerciseDisplay() {
    return Column(
      children: [
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
    );
  }

  Widget _buildExerciseScrollRow() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      height: 80, // Adjust as needed
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                  color: isSelected ? Colors.blue : Colors.grey[300]!, // Blue border for selected item
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
    return Container();
  }
}

