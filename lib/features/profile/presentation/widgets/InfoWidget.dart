import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:io/ansi.dart';

import '../../../../config/themes/common_styles.dart';
import '../pages/PersonalInfo.dart';

class InfoWidget extends StatefulWidget {
  const InfoWidget({Key? key}) : super(key: key);

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  final _formKey = GlobalKey<FormState>();

  double calories = 0; // Initial value
  double maxCalories = 5000;

  double steps = 0;
  double maxSteps = 10000;
  bool isEditing = false;

  // Define controllers for the form fields and set initial values
  final TextEditingController _heightController =
      TextEditingController(text: '170');
  final TextEditingController _weightController =
      TextEditingController(text: '87');

  final TextEditingController _ageController =
      TextEditingController(text: '30');

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _saveInfo() {
    // You can handle saving data here
    if (_formKey.currentState!.validate()) {
      final height = _heightController.text;
      final weight = _weightController.text;

      final age = _ageController.text;

      print('height: $height');
      print('weight: $weight');
      print('Age: $age');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        key: _formKey,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            // User Info Form with initial values
            Text(
              'My Height',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: theme_green,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
              decoration: textField_decoration,
              child: TextField(
                controller: _heightController,
                style: inputText,
                cursorColor: theme_green,
                decoration: InputDecoration(
                  suffixText: 'cm',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Icon(
                      Icons.accessibility,
                      color: theme_grey,
                    ),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),

            Text(
              'My Weight',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: theme_green,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
              decoration: textField_decoration,
              child: TextFormField(
                controller: _weightController,
                style: inputText,
                cursorColor: theme_green,
                decoration: InputDecoration(
                  suffixText: 'kg',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Icon(
                      Icons.accessibility,
                      color: theme_grey,
                    ),
                  ),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
                onSaved: (value) {
                  print('Height: $value');
                },
              ),
            ),

            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Target Calories:',
                        style: TextStyle(
                          fontSize: 14,
                          color: theme_green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: textField_decoration,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  calories.toStringAsFixed(0),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  ' Calories/Day',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: theme_pink,
                                inactiveTrackColor: theme_green,
                                trackHeight: 3,
                                thumbColor: theme_pink,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 8.0),
                                overlayColor: theme_pink.withAlpha(25),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 15.0),
                              ),
                              child: Slider(
                                value: calories,
                                onChanged: (value) {
                                  setState(() {
                                    calories =
                                        (value / 50).round() * 50.toDouble();
                                  });
                                },
                                min: 0,
                                max: maxCalories,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Target Steps:',
                        style: TextStyle(
                          fontSize: 14,
                          color: theme_green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: textField_decoration,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  steps.toStringAsFixed(0),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  ' Steps/Day',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: theme_pink,
                                inactiveTrackColor: theme_green,
                                trackHeight: 3,
                                thumbColor: theme_pink,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 8.0),
                                overlayColor: theme_pink.withAlpha(25),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 15.0),
                              ),
                              child: Slider(
                                value: steps,
                                onChanged: (value) {
                                  setState(() {
                                    steps =
                                        (value / 50).round() * 50.toDouble();
                                  });
                                },
                                min: 0,
                                max: maxSteps,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: theme_darkblue,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                    // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Button border radius
                    ),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: _saveInfo,
                child: Text(
                  'Save Info', style: TextStyle(color: primary_color),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
