import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

import '../widgets/ConfirmButton.dart';
import '../widgets/InputField.dart';
import '../widgets/MealTypeButton.dart';
import '../widgets/ReminderButton.dart';

class NewMeal extends StatefulWidget {
  const NewMeal({Key? key}) : super(key: key);
  @override
  _NewMealState createState() => _NewMealState();
}

class _NewMealState extends State<NewMeal> {
  String? selectedReminder;

  void _updateReminder(String label) {
    setState(() {
      selectedReminder = label;
    });
  }

  String? selectedMealType;

  void _updateMealType(String label) {
    setState(() {
      selectedMealType = label;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme_darkblue,
      appBar: AppBar(
        toolbarHeight: 150.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/Logo/2x/Icon_1@2x.png',
              height: 100,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: theme_darkblue,
        elevation: 0,
      ),
        body: SafeArea(
    child: SingleChildScrollView(
      child: Container(

        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),

        height: MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            MediaQuery.of(context).padding.top,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),

            Center(
              child: Text(
                "New Meal",
                style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),

            SizedBox(height: 10),
            InputField(label: 'Meal Name', hint: 'Enter meal name'),


            SizedBox(height: 16),
            Text("Meal time/type", style: TextStyle(color: Colors.grey[700])),


            SizedBox(height: 8),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: MealTypeButton(
                          label: "Breakfast",
                          isSelected: selectedMealType == "Breakfast",
                          onSelected: _updateMealType,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: MealTypeButton(
                          label: "Lunch",
                          isSelected: selectedMealType == "Lunch",
                          onSelected: _updateMealType,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: MealTypeButton(
                          label: "Dinner",
                          isSelected: selectedMealType == "Dinner",
                          onSelected: _updateMealType,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: MealTypeButton(
                          label: "Snack",
                          isSelected: selectedMealType == "Snack",
                          onSelected: _updateMealType,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),



            SizedBox(height: 16),
            InputField(label: 'Calories', hint: 'eg. 320 Calo'),


            SizedBox(height: 16),
            Text("Set Reminder", style: TextStyle(color: Colors.grey[700])),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ReminderButton(
                  "Yes",
                  isSelected: selectedReminder == "Yes",
                  onSelected: (label) {
                    setState(() {
                      selectedReminder = label;
                    });
                  },
                ),
                SizedBox(width: 10),
                ReminderButton(
                  "No",
                  isSelected: selectedReminder == "No",
                  onSelected: (label) {
                    setState(() {
                      selectedReminder = label;
                    });
                  },
                ),
              ],
            ),




            SizedBox(height: 10),

            ConfirmButton('Confirm'),

          ],
        ),
          ),), ),
    );
  }
}

