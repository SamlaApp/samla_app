import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../config/themes/common_styles.dart';
import '../../../data/models/exercise_model.dart';


class DayCard extends StatelessWidget {
  final String day;
  final VoidCallback onAddExercise;
  final List<ExerciseModel> exercises;

  DayCard({required this.day, required this.onAddExercise, required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              day,
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            contentPadding: EdgeInsets.all(16),
          ),
          Divider(height: 0),
          ...exercises.map((exercise) => ExerciseItem(exercise: exercise, onTap: () {})).toList(),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: onAddExercise,
            child: Text(
              'Add Exercise',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: theme_darkblue,
            ),
          ),
        ],
      ),
    );
  }
}

class ExerciseItem extends StatelessWidget {
  final ExerciseModel exercise;
  final VoidCallback onTap;

  ExerciseItem({
    required this.exercise,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Image.network(
              exercise.gifUrl,  // Assuming gifUrl contains the image URL
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            exercise.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          // You can add a trailing button or icon if needed
        ),
      ),
    );
  }
}
