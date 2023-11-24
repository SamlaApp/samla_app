import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseDay.dart';
import 'package:samla_app/features/training/presentation/cubit/Exercises/exercise_cubit.dart';
import 'package:samla_app/features/training/presentation/cubit/viewDayExercise/viewDayExercise_cubit.dart';
import 'package:samla_app/features/training/training_di.dart' as di;


class ViewDayExerciseItem extends StatefulWidget {
  final int? id;
  final String name;
  final String bodyPart;
  final String equipment;
  final String gifUrl;
  final String target;
  final String day;
  final String instructions;
  final List<String> secondaryMuscles;
  final LinearGradient gradient;
  final int templateId;
  final Function onRemove;

  const ViewDayExerciseItem({
    Key? key,
    this.id,
    required this.name,
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.target,
    required this.instructions,
    required this.secondaryMuscles,
    required this.gradient,
    required this.day,
    required this.templateId,
    required this.onRemove,
  }) : super(key: key);

  @override
  _ViewDayExerciseItemState createState() => _ViewDayExerciseItemState();
}

class _ViewDayExerciseItemState extends State<ViewDayExerciseItem> {
  final String _baseURL = 'https://samla.mohsowa.com/api/training/image/'; // api url for images
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1); // capitalize first letter of string

  final exercisesCubit = di.sl.get<ExerciseCubit>();
  final viewDayExerciseCubit = di.sl.get<ViewDayExerciseCubit>();

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        backgroundBlendMode: BlendMode.darken,
        borderRadius: BorderRadius.circular(10),
        gradient: widget.gradient,
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            title: Text(
              capitalize(widget.name),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white,
                    size: 30,
                  ),
                ),

                // delete button
                IconButton(
                  onPressed: () {
                    exercisesCubit.removeExerciseFromPlan(exerciseID: widget.id!, day: widget.day, templateID: widget.templateId);
                    viewDayExerciseCubit.getExercisesDay(day: widget.day, templateID: widget.templateId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Exercise removed from plan'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),

          _buildSummaryRow(),

          if (_isExpanded) _buildExpandedContent(),
        ],
      ),
    );
  }



  Widget _buildSummaryRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDetailContainer('Body Part', capitalize(widget.bodyPart)),
          _buildDetailContainer('Equipment', capitalize(widget.equipment)),
        ],
      ),
    );
  }

  Widget _buildDetailContainer(String label, String value) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: Container(
            width: 160,
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: Colors.white, // Match the background color
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
              child: Text(
                label,
                style: TextStyle(
                  color: themeDarkBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                  _baseURL + widget.gifUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container();
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return  const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
              ),
            ),
          ),


          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Target: ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    _buildDetailText('${widget.target}.'),
                  ],
                ),
                const SizedBox(height: 5),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Secondary Muscles: ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    _buildDetailText('${widget.secondaryMuscles.join(', ')}.'),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Aligns children to the start of the column
              children: [
                const Text(
                  'Instructions:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                _buildDetailText(widget.instructions),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailText(String text) {
    return Text(text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.visible,
          decoration: TextDecoration.none,
        ),
        softWrap: true,
        overflow: TextOverflow.visible,
        textAlign: TextAlign.justify);
  }
}
