import 'package:flutter/material.dart';
import 'package:samla_app/features/training/data/models/exercise_model.dart';

class ExerciseSelectionDialog extends StatefulWidget {
  final String day;
  final List<ExerciseModel> allExercises;
  final Function(List<ExerciseModel>) onSelectedExercises;

  final bool isLoading;

  ExerciseSelectionDialog({
    required this.day,
    required this.allExercises,
    required this.onSelectedExercises,
    required this.isLoading, // Add this parameter
  });

  @override
  _ExerciseSelectionDialogState createState() => _ExerciseSelectionDialogState();
}
class _ExerciseSelectionDialogState extends State<ExerciseSelectionDialog> {
  final Set<ExerciseModel> selectedExercises = {};

  @override
  Widget build(BuildContext context) {
    print('Building ExerciseSelectionDialog, isLoading: ${widget.isLoading}');
    return Dialog(
      insetPadding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(5.0),
          width: 400,
          child: widget.isLoading
              ? Center(child: CircularProgressIndicator())
              : buildDialogContent(context),
        ),
      ),
    );
  }

  Widget buildDialogContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildHeader(),
        Divider(),
        buildExerciseList(),
      ],
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close),
        ),
    GestureDetector(
    onTap: () {
    widget.onSelectedExercises(selectedExercises.toList());
    Navigator.of(context).pop();
    },
          child: Text(
            'Add ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        )
      ],
    );
  }





  Widget buildExerciseList() {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.allExercises.length,
        itemBuilder: (context, index) {
          final exercise = widget.allExercises[index];
          final isSelected = selectedExercises.contains(exercise);

          return ExerciseItem(
            exercise: exercise,
            isSelected: isSelected,
            onTap: () {
              setState(() {
                if (isSelected) {
                  selectedExercises.remove(exercise);
                } else {
                  selectedExercises.add(exercise);
                }
              });
            },
          );
        },
      ),
    );
  }
}

class ExerciseItem extends StatelessWidget {
  final ExerciseModel exercise;
  final bool isSelected;
  final VoidCallback onTap;

  ExerciseItem({
    required this.exercise,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    print(exercise.gifUrl);
    return InkWell(
      onTap: onTap,
      child: Card(
        color: isSelected ? Colors.lightBlue[50] : null,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Image.network(
              exercise.gifUrl, // Assuming gifUrl is the image URL
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
          // Optionally add trailing or other widgets as needed
        ),
      ),
    );
  }
}