import 'package:flutter/material.dart';
import 'package:samla_app/features/training/presentation/widgets/startTraining/history.dart';
import '../../../../config/themes/new_style.dart';
import '../../domain/entities/ExerciseLibrary.dart';
import '../cubit/History/history_cubit.dart';
class ExerciseInfoStartPage extends StatefulWidget {


  final String name;
  final String gifUrl;
  final String bodyPart;
  final String equipment;
  final String target;
  final List<String> secondaryMuscles;
  final String instructions;
  final HistoryCubit historyCubit;
  final ExerciseLibrary selectedExercise;

  const ExerciseInfoStartPage({
    super.key,
    required this.gifUrl,
    required this.bodyPart,
    required this.equipment,
    required this.target,
    required this.secondaryMuscles,
    required this.instructions,
    required this.name,
    required this.historyCubit,
    required this.selectedExercise,
  });

  @override
  ExerciseInfoStartPageState createState() => ExerciseInfoStartPageState();
}

class ExerciseInfoStartPageState extends State<ExerciseInfoStartPage> {
  bool _isExpanded = false;
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: primaryDecoration.copyWith(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      width: MediaQuery.of(context).size.width * 0.95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              // 30% of screen hight
              height: MediaQuery.of(context).size.height * 0.31,
              child: Row(
                //center image
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.gifUrl,
                      width: 200,
                      // max hight is 20% of screen hight
                      height: MediaQuery.of(context).size.height * 0.22,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // scrollable list of info
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          customBorderContainer(
                            'Body Part',
                            widget.bodyPart,
                          ),
                          const SizedBox(height: 5),
                          customBorderContainer(
                            'Equipment',
                            widget.equipment,
                          ),
                          const SizedBox(height: 5),
                          customBorderContainer(
                            'Target',
                            widget.target,
                          ),
                          const SizedBox(height: 5),
                          customBorderContainer(
                            'Secondary Muscles',
                            widget.secondaryMuscles.join(', '),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 1,
            thickness: 0.5,
            indent: 10,
            endIndent: 10,
          ),
          ListTile(
            title: Text(
              'Instructions of ${widget.name}',
              style: TextStyle(
                color: themeGrey,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              // Use this to constrain the width of the Row
              children: [
                IconButton(
                  icon: _isExpanded
                      ? const Icon(Icons.expand_less)
                      : const Icon(Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.history),
                  // Replace with your history icon
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => HistoryDialog(
                        historyCubit: widget.historyCubit,
                        selectedExercise: widget.selectedExercise,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          if (_isExpanded)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 8, 16),
                child: buildNumberedList(
                  widget.instructions,
                  TextStyle(
                    fontSize: 12,
                    color: themeGrey,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
        ],
      ),
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
              border: Border.all(color: themeDarkBlue.withOpacity(0.5), width: 0.9),
              // Smaller border width
              borderRadius: BorderRadius.circular(6), // Smaller border radius
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 6.0, bottom: 2.0),
              child: Text(
                capitalize(value),
                style:  TextStyle(
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
