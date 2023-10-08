import 'package:flutter/material.dart';

class Exercise {
  final String name;
  final String? description;
  bool isSelected;

  Exercise({
    required this.name,
    this.description,
    this.isSelected = false,
  });
}

class ExerciseListView extends StatefulWidget {
  final List<Exercise> availableExercises;

  ExerciseListView({required this.availableExercises});

  @override
  _ExerciseListViewState createState() => _ExerciseListViewState();
}

class _ExerciseListViewState extends State<ExerciseListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.availableExercises.length,
            itemBuilder: (context, index) {
              final exercise = widget.availableExercises[index];
              return ListTile(
                leading: Checkbox(
                  value: exercise.isSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      exercise.isSelected = value ?? false;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  activeColor: Colors.green,
                ),
                title: Text(exercise.name),
                subtitle:
                exercise.description != null ? Text(exercise.description!) : null,
                onTap: () {
                  // Handle tapping the exercise if needed
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class AddExerciseSheet extends StatefulWidget {
  final void Function(List<Exercise>) onAdd;

  AddExerciseSheet({required this.onAdd});

  @override
  _AddExerciseSheetState createState() => _AddExerciseSheetState();
}

class _AddExerciseSheetState extends State<AddExerciseSheet> {
  TextEditingController _exerciseNameController = TextEditingController();
  TextEditingController _exerciseDescriptionController = TextEditingController();
  List<Exercise> selectedExercises = [];

  @override
  void dispose() {
    _exerciseNameController.dispose();
    _exerciseDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Dummy list of available exercises
    final List<Exercise> dummyExercises = [
      Exercise(name: "Exercise 1", description: "Description 1"),
      Exercise(name: "Exercise 2", description: "Description 2"),
      Exercise(name: "Exercise 3", description: "Description 3"),
    ];

    return DefaultTabController(
      length: 2,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              onTap: (index) {
                setState(() {
                  selectedExercises.clear(); // Clear selected exercises when switching tabs
                });
              },
              tabs: [
                Tab(text: 'Select from List'),
                Tab(text: 'Add New Exercise'),
              ],
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: TabBarView(
                children: [
                  // Tab 1 content
                  ExerciseListView(availableExercises: dummyExercises),

                  // Tab 2 content
                  Column(
                    children: [
                      TextFormField(
                        controller: _exerciseNameController,
                        decoration: InputDecoration(
                          labelText: 'Exercise Name',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _exerciseDescriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description (optional)',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (selectedExercises.isNotEmpty) {
                  widget.onAdd(selectedExercises);
                } else {
                  // Handle selecting an exercise from the list
                  // You can show a dialog or navigate to a list screen here
                }
              },
              child: Text('Add Exercise'),
            ),
          ],
        ),
      ),
    );
  }
}
