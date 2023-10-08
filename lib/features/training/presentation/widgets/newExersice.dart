import 'package:flutter/material.dart';

import '../pages/newRoutineScreen.dart';

class Exercise {
  final String name;
  final String? description;
  final String? imageUrl;
  bool isSelected;

  Exercise({
    required this.name,
    this.description,
    this.imageUrl,
    this.isSelected = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Exercise &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              description == other.description &&
              imageUrl == other.imageUrl &&
              isSelected == other.isSelected;

  @override
  int get hashCode =>
      name.hashCode ^
      description.hashCode ^
      imageUrl.hashCode ^
      isSelected.hashCode;
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
              return ExerciseTile(
                exercise: exercise,
                onCheckboxChanged: (bool? value) {
                  setState(() {
                    exercise.isSelected = value ?? false;
                  });
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

class _AddExerciseSheetState extends State<AddExerciseSheet> with SingleTickerProviderStateMixin {  // Updated here
  TextEditingController _exerciseNameController = TextEditingController();
  TextEditingController _exerciseDescriptionController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  TabController? _tabController;  // Added here

  final List<Exercise> dummyExercises = [
    Exercise(name: "Exercise 1", description: "Description 1", imageUrl: 'https://picsum.photos/200/200/?blur'),
    Exercise(name: "Exercise 2", description: "Description 2", imageUrl: 'https://picsum.photos/200/200/?blur'),
    Exercise(name: "Exercise 3", description: "Description 3", imageUrl: 'https://picsum.photos/200/200/?blur'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);  // Initialized here
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _exerciseNameController.dispose();
    _exerciseDescriptionController.dispose();
    _tabController?.dispose();  // Disposed here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            controller: _tabController,  // Updated here
              onTap: (index) {
                setState(() {
                  dummyExercises.forEach((exercise) {
                    exercise.isSelected = false;  // Clear selected exercises when switching tabs
                  });
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
                controller: _tabController,  // Pass the _tabController here
                children: [
                  // Tab 1 content
                  ExerciseListView(availableExercises: dummyExercises),

                  // Tab 2 content
                  Column(
                    children: [
                      TextFormField(
                        controller: _imageUrlController,
                        decoration: InputDecoration(
                          labelText: 'Image URL (optional)',
                        ),
                      ),
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
          Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  if (_tabController?.index == 0) {  // Check if the first tab is active
                    final selectedExercises = dummyExercises.where((exercise) => exercise.isSelected).toList();
                    if (selectedExercises.isNotEmpty) {
                      widget.onAdd(selectedExercises);
                      Navigator.of(context).pop();
                    } else {
                      // Handle the case when no exercises are selected
                    }
                  } else if (_exerciseNameController.text.isNotEmpty) {  // Check if the second tab is active
                    final newExercise = Exercise(
                      name: _exerciseNameController.text,
                      description: _exerciseDescriptionController.text,
                      imageUrl: _imageUrlController.text.isNotEmpty
                          ? _imageUrlController.text
                          : null,
                    );
                    widget.onAdd([newExercise]);
                    Navigator.of(context).pop();
                  } else {
                    // Handle the case when no name is provided
                  }
                },
                child: Text('Add Exercise'),
              );
              },
            ),
          ],
        ),
      );
  }
}

class ExerciseTile extends StatelessWidget {
  final Exercise exercise;
  final ValueChanged<bool?>? onCheckboxChanged;

  ExerciseTile({required this.exercise, this.onCheckboxChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: exercise.imageUrl != null
            ? Image.network(exercise.imageUrl!)
            : null,
        title: Text(exercise.name),
        subtitle: exercise.description != null
            ? Text(exercise.description!)
            : null,
        trailing: Checkbox(
          value: exercise.isSelected,
          onChanged: onCheckboxChanged,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          activeColor: Colors.green,
        ),
      ),
    );
  }
}

