import 'package:flutter/material.dart';
import '../../../../config/themes/new_style.dart';

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

class ExerciseTiles extends StatefulWidget {
  final ExercisesItem exercise;

  const ExerciseTiles({super.key, required this.exercise});

  @override
  State<ExerciseTiles> createState() => _ExerciseTilesState();
}

class _ExerciseTilesState extends State<ExerciseTiles> {
  final baseURL = 'https://samla.mohsowa.com/api/training/image/';

  // api url for images
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  // capitalize first letter of string
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showExerciseDetails(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white12,
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                image: DecorationImage(
                  image: NetworkImage(baseURL + widget.exercise.gifUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6.0), // Reduce padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      capitalize(widget.exercise.name),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis, // Ellipsis for long names
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Tap for details',
                      style: TextStyle(fontSize: 12, color: Colors.white54),
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
          surfaceTintColor: Colors.white,
          insetPadding: const EdgeInsets.all(1.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          backgroundColor: Colors.white,
          child: SizedBox(
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
                            baseURL + widget.exercise.gifUrl,
                            width: MediaQuery.of(context).size.width * 0.43,
                            height: MediaQuery.of(context).size.width * 0.43,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Column(
                          children: [
                            customBorderContainer(
                                'BodyPart', widget.exercise.bodyPart),
                            customBorderContainer(
                                'Equipment', widget.exercise.equipment),
                            customBorderContainer(
                                'Target', widget.exercise.target),
                            customBorderContainer('Secondary Muscles',
                                widget.exercise.secondaryMuscles.join(', ')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 10,
                    thickness: 0.5,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildNumberedList(
                        widget.exercise.instructions,
                        const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.visible,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),

                  // Close button
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.close, color: white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              themeDarkBlue, // Change background color
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        label:
                            const Text('Close', style: TextStyle(color: white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildNumberedList(String instructions, TextStyle textStyle) {
    final lines =
        instructions.split('\n').where((line) => line.trim().isNotEmpty);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        final index = lines.toList().indexOf(line) + 1;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$index.',
              style: textStyle,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                line,
                style: textStyle,
                softWrap: true,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget customBorderContainer(String label, String value) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.33,
            // Decreased width
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            // Smaller padding
            decoration: BoxDecoration(
              border:
                  Border.all(color: themeDarkBlue.withOpacity(0.5), width: 0.9),
              // Smaller border width
              borderRadius: BorderRadius.circular(6), // Smaller border radius
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 6.0, bottom: 2.0),
              child: Text(
                capitalize(value),
                style: TextStyle(
                  color: themeDarkBlue.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                  fontSize: 12, // Smaller font size
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: -2,
          left: -5, // Adjusted left position
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8), // Smaller border radius
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  colors: [themePink, themeDarkBlue],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12, // Smaller font size
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
