import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseDay.dart';
import 'package:samla_app/features/training/presentation/cubit/Exercises/exercise_cubit.dart';
import 'package:samla_app/features/training/training_di.dart' as di;

class ExerciseItem extends StatefulWidget {
  final int? id;
  final String name;
  final String bodyPart;
  final String equipment;
  final String gifUrl;
  final String target;
  final String instructions;
  final List<String> secondaryMuscles;
  final LinearGradient gradient;
  final int templateId;

  const ExerciseItem({
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
    required this.templateId,
  }) : super(key: key);

  @override
  _ExerciseItemState createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<ExerciseItem> {
  final String _baseURL =
      'https://samla.mohsowa.com/api/training/image/'; // api url for images
  String capitalize(String s) =>
      s[0].toUpperCase() + s.substring(1); // capitalize first letter of string

  final exercisesCubit = di.sl.get<ExerciseCubit>();

  bool _isExpanded = false;

  // days of the week
  final _formKey = GlobalKey<FormState>();
  bool sun = false;
  bool mon = false;
  bool tue = false;
  bool wed = false;
  bool thu = false;
  bool fri = false;
  bool sat = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // if all days are false, show error
      if (!sun && !mon && !tue && !wed && !thu && !fri && !sat) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one day'),
          ),
        );
      } else {
        ExerciseDay exerciseDay = ExerciseDay(
          id: widget.id,
          sunday: sun,
          monday: mon,
          tuesday: tue,
          wednesday: wed,
          thursday: thu,
          friday: fri,
          saturday: sat,
          exercise_template_id: widget.templateId,
          exercise_library_id: widget.id!,
        );

        exercisesCubit.addExerciseToPlan(exerciseDay);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Exercise added to plan'),
          ),
        );
      }
    }
  }

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
                color: white,
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
                    color: white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          _buildSummaryRow(),
          if (!_isExpanded)
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Select Days: ',
                          style: TextStyle(
                            color: white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 25,
                          child: ElevatedButton.icon(
                              onPressed: () {
                                _submitForm();
                              },
                              icon: const Icon(Icons.add,
                                  color: themeDarkBlue, size: 20),
                              label: const Text('Add ',
                                  style: TextStyle(
                                      color: themeDarkBlue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: white,
                                backgroundColor: white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Sun',
                              style: TextStyle(
                                  color: white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Checkbox(
                              value: sun,
                              onChanged: (bool? value) {
                                setState(() {
                                  sun = value!;
                                });
                              },
                              shape: const CircleBorder(),
                              activeColor: white,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Mon',
                              style: TextStyle(
                                  color: white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Checkbox(
                              value: mon,
                              onChanged: (bool? value) {
                                setState(() {
                                  mon = value!;
                                });
                              },
                              shape: const CircleBorder(),
                              activeColor: white,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Tue',
                              style: TextStyle(
                                  color: white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Checkbox(
                              value: tue,
                              onChanged: (bool? value) {
                                setState(() {
                                  tue = value!;
                                });
                              },
                              shape: const CircleBorder(),
                              activeColor: white,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Wed',
                              style: TextStyle(
                                  color: white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Checkbox(
                              value: wed,
                              onChanged: (bool? value) {
                                setState(() {
                                  wed = value!;
                                });
                              },
                              shape: const CircleBorder(),
                              activeColor: white,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Thu',
                              style: TextStyle(
                                  color: white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Checkbox(
                              value: thu,
                              onChanged: (bool? value) {
                                setState(() {
                                  thu = value!;
                                });
                              },
                              shape: const CircleBorder(),
                              activeColor: white,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Fri',
                              style: TextStyle(
                                  color: white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Checkbox(
                              value: fri,
                              onChanged: (bool? value) {
                                setState(() {
                                  fri = value!;
                                });
                              },
                              shape: const CircleBorder(),
                              activeColor: white,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Sat',
                              style: TextStyle(
                                  color: white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Checkbox(
                              value: sat,
                              onChanged: (bool? value) {
                                setState(() {
                                  sat = value!;
                                });
                              },
                              shape: const CircleBorder(),
                              activeColor: white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
            width: MediaQuery.of(context).size.width * 0.4,
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            decoration: BoxDecoration(
              border: Border.all(color: white),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: white,
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
              color: white, // Match the background color
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
              child: Text(
                label,
                style: const TextStyle(
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
              child: Image.network(_baseURL + widget.gifUrl, fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                return Container();
              }, loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(
                    color: white,
                  ),
                );
              }),
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
                          color: white,
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
                          color: white,
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
                    color: white,
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
          color: white,
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
