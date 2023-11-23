import 'package:flutter/material.dart';

import '../../../../config/themes/common_styles.dart';

class ExerciseInfoStartPage extends StatefulWidget {
  final String name;
  final String gifUrl;
  final String bodyPart;
  final String equipment;
  final String target;
  final List<String> secondaryMuscles;
  final String instructions;

  ExerciseInfoStartPage({
    required this.gifUrl,
    required this.bodyPart,
    required this.equipment,
    required this.target,
    required this.secondaryMuscles,
    required this.instructions, required this.name,
  });

  @override
  _ExerciseInfoStartPageState createState() => _ExerciseInfoStartPageState();
}

class _ExerciseInfoStartPageState extends State<ExerciseInfoStartPage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
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
                    widget.gifUrl,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    CustomBorderContainer('BodyPart', widget.bodyPart),
                    CustomBorderContainer('Equipment', widget.equipment),
                    CustomBorderContainer('Target', widget.target),
                    CustomBorderContainer('Secondary Muscles', widget.secondaryMuscles.join(', ')),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 1,
            thickness: 0.5,
            indent: 0,
            endIndent: 0,
          ),
          ListTile(
            title: Text(
              'Instructions of ${widget.name}',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            trailing: IconButton(
              icon: _isExpanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Container(
              padding: const EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.instructions,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    decoration: TextDecoration.none,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
        ],
      ),
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
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            decoration: BoxDecoration(
              border: Border.all(color: theme_red, width: 1.5),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ),
        Positioned(
          top: -2,
          left: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: theme_red,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
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
