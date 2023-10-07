import 'package:flutter/material.dart';

class MuscleGroupCard extends StatelessWidget {
  final String muscleGroupName;
  final String imageUrl;

  MuscleGroupCard({required this.muscleGroupName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
        minVerticalPadding: 50.0,
        leading: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ],
          ),
        ),
        title: Text(
          muscleGroupName,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}