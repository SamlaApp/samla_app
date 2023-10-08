import 'package:flutter/material.dart';

import '../../../../config/themes/common_styles.dart';
import '../pages/ex.dart';

class ExerciseTile extends StatefulWidget {
  final Exercise exercise;

  ExerciseTile({required this.exercise});

  @override
  _ExerciseTileState createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  List<SetData> sets = [
    SetData(),
    SetData(),
    SetData(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (widget.exercise.imagePath != null)
                      Image.asset(
                        widget.exercise.imagePath!,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        widget.exercise.name,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert, size: 20.0, color: Colors.grey),
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Edit',
                          child: Text('Edit'),
                        ),
                      ],
                      onSelected: (value) {},
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                if (widget.exercise.description != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      widget.exercise.description!,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Set      ', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Previous  ', style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(child: Text('                  Reps', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(child: Text('Kg', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(width: 24.0), // Placeholder for checkbox
                  ],
                ),
                Column(
                  children: sets.asMap().entries.map((entry) {
                    int idx = entry.key;
                    SetData set = entry.value;
                    final Key dismissibleKey = UniqueKey(); // Generate a unique key
                    return Dismissible(
                      key: dismissibleKey,
                      onDismissed: (direction) {
                        setState(() {
                          sets.removeAt(idx);
                        });
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${idx + 1}'),
                            SizedBox(width: 40.0),
                            Text('${set.previousReps} x ${set.previousKg}kg', style: TextStyle(color: Colors.grey[600])),
                            Spacer(),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                initialValue: set.reps.toString(),
                                onChanged: (value) {
                                  set.reps = int.tryParse(value) ?? 0;
                                },
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                initialValue: set.kg.toString(),
                                onChanged: (value) {
                                  set.kg = double.tryParse(value) ?? 0.0;
                                },
                              ),
                            ),
                            Checkbox(
                              value: set.isDone,
                              onChanged: (bool? value) {
                                setState(() {
                                  set.isDone = value!;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              activeColor: theme_green,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Divider(),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      sets.add(SetData());
                    });
                  },
                  icon: Icon(Icons.add, size: 16.0, color: theme_green),
                  label: Text("Add Set", style: TextStyle(fontSize: 14, color: theme_green)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SetData {
  int reps = 0;
  double kg = 0.0;
  bool isDone = false;
  int previousReps = 0;
  double previousKg = 0.0;
}
