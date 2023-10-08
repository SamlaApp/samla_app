import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

import '../widgets/newExersice.dart';
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
class NewRoutineScreen extends StatefulWidget {
  @override
  _NewRoutineScreenState createState() => _NewRoutineScreenState();
}

class _NewRoutineScreenState extends State<NewRoutineScreen> {
  TextEditingController _routineNameController = TextEditingController();
  List<Exercise> _selectedExercises = [];

  @override
  void dispose() {
    _routineNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('New Routine'),
        backgroundColor: theme_green, // Use your desired color
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () {
              // Handle QR code button press
              // You can navigate to a QR code screen here
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextFormField(
            controller: _routineNameController,
            decoration: InputDecoration(
              labelText: 'Routine Name',
            ),
          ),
          SizedBox(height: 20.0),
          Column(
            children: _selectedExercises
                .map((exercise) => ExerciseTile(exercise: exercise))  // Use ExerciseTile here
                .toList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openAddExerciseSheet();
        },
        child: Icon(Icons.add),
        backgroundColor: theme_green, // Use your desired color
      ),
    );
  }

  void _openAddExerciseSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return AddExerciseSheet(
          onAdd: (exercises) {
            setState(() {
              _selectedExercises.addAll(exercises);
            });
          },
        );
      },
    );
  }

}
//
// class ExerciseTile extends StatelessWidget {
//   final Exercise exercise;
//
//   ExerciseTile({required this.exercise});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12.0),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: ListTile(
//         title: Text(exercise.name),
//         subtitle: exercise.description != null
//             ? Text(exercise.description!)
//             : null,
//         trailing: IconButton(
//           icon: Icon(Icons.delete),
//           onPressed: () {
//             // Handle exercise deletion
//             // You can show a confirmation dialog and then remove it from the list
//             _removeExercise(exercise);
//           },
//         ),
//       ),
//     );
//   }
//
//   void _removeExercise(Exercise exercise) {
//     // You can add the logic to remove the exercise from the list here
//   }

