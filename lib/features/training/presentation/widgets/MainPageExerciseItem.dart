import 'package:flutter/material.dart';

import '../../../../config/themes/common_styles.dart';

class ExercisesItem {
  final String name;
  final String bodyPart;
  final String equipment;
  final String gifUrl;
  final String target;
  final String instructions;
  final List<String> secondaryMuscles;

  ExercisesItem({
    required this.name,
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.target,
    required this.instructions,
    required this.secondaryMuscles,
  });
}

class ExerciseTiles extends StatelessWidget {
  final ExercisesItem exercise;

  const ExerciseTiles({super.key, required this.exercise});

  final  baseURL = 'https://samla.mohsowa.com/api/training/image/'; // api url for images

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {
        _showExerciseDetails(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        // Adjust margins
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: theme_red.withOpacity(0.5), // Light border color
            width: 1.0, // Border width
          ),
        ),


        child: Row(
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(baseURL + exercise.gifUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Content on the right with smaller padding
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6.0), // Reduce padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      exercise.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      // Adjust font size
                      maxLines: 2,
                      // Limit to 2 lines
                      overflow:
                          TextOverflow.ellipsis, // Ellipsis for long names
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Tap for details',
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey), // Adjust font size
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExerciseDetails(BuildContext context) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(1.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          backgroundColor: Colors.white,
          child: Container(
            // take 90% of screen width
            width: MediaQuery.of(context).size.width * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      //center image
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            baseURL + exercise.gifUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    //space in between
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBorderContainer('bodyPart', exercise.bodyPart),
                      CustomBorderContainer('Equipment', exercise.equipment),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBorderContainer('Target', exercise.target),
                      CustomBorderContainer('Secondary Muscles',
                          exercise.secondaryMuscles.join(', ')),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     CustomBorderContainer('Instructions', exercise.instructions),
                  //   ],
                  // ),
                  //Instructions
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        exercise.instructions,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey), // Adjust font size
                      ),
                    ),
                  ),
                  // Custom widget
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme_green, // Change background color
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Close',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white)), // Adjust font size
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget CustomBorderContainer(String label, String value) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: Container(
            width: 140,
            // Decreased width
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            // Smaller padding
            decoration: BoxDecoration(
              border: Border.all(color: theme_red, width: 1.5),
              // Smaller border width
              borderRadius: BorderRadius.circular(6), // Smaller border radius
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 12, // Smaller font size
              ),
            ),
          ),
        ),
        Positioned(
          top: -2,
          left: 3, // Adjusted left position
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8), // Smaller border radius
            child: Container(
              color: theme_red,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              // Smaller padding
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12, // Smaller font size
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
