import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:samla_app/config/themes/common_styles.dart';


class NewWorkout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Workout'),
        backgroundColor: theme_green, // Assuming theme_green is a defined color
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'images/qrcode.svg',
              color: Colors.white, // Assuming iconColor is a defined color
            ),
            onPressed: () => Navigator.pushNamed(context, '/QRcode'),
          ),
        ],
      ),
        body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top:100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.fitness_center,
                size: 50.0,
                color: theme_green,
              ),
              SizedBox(height: 8.0), // Adds space between the icon and the text
              Text(
                'Get started',
                style: TextStyle(
                  fontSize: 24.0, // Adjust font size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0), // Adds space between the texts
              Text(
                'Add an exercise or scan QR code or NFC tag to add an Exercise',
                textAlign: TextAlign.center,
                style: TextStyle( fontSize: 16.0, // Adjust font size as needed
                ),
              ),
              SizedBox(height: 30.0), // Adds space between the text and the button
              ElevatedButton.icon(
                onPressed: () {
                  // Handle button press
                },
                icon: Icon(Icons.add),
                label: Text('Add Exercise'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme_green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


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
// MuscleGroupCard(
//   muscleGroupName: 'Chest',
//   imageUrl: 'https://v2.exercisedb.io/image/mC3NaRoKzI9D-S',
// ),
// MuscleGroupCard(
//   muscleGroupName: 'Back',
//   imageUrl: 'https://v2.exercisedb.io/image/Df5zu4OmWB97T8',
// ),
// MuscleGroupCard(
//   muscleGroupName: 'Shoulders',
//   imageUrl: 'https://v2.exercisedb.io/image/rJaV3eeqGfGiIl',
// ),
// MuscleGroupCard(
//   muscleGroupName: 'Biceps',
//   imageUrl: 'https://v2.exercisedb.io/image/motQtaEI1aag0C',
// ),
// MuscleGroupCard(
//   muscleGroupName: 'Triceps',
//   imageUrl: 'https://v2.exercisedb.io/image/r8nXDRpWfBw7Qu',
// ),
