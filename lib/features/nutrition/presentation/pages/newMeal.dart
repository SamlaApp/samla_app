import 'package:flutter/material.dart';

class NewMeal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'New Meal',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Meal Name'),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter meal name',
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Time Start'),
                      DropdownButton<String>(
                        value: '05:00am',
                        items: <String>['05:00am', '06:00am', '07:00am'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                      Text('Time End'),
                      DropdownButton<String>(
                        value: '09:00am',
                        items: <String>['09:00am', '10:00am', '11:00am'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Calories'),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: '320 Calo',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Set Reminder'),
                  Row(
                    children: [
                      Radio(
                        value: true,
                        groupValue: true,
                        onChanged: (bool? value) {},
                      ),
                      Text('Yes'),
                      SizedBox(width: 20),
                      Radio(
                        value: false,
                        groupValue: true,
                        onChanged: (bool? value) {},
                      ),
                      Text('No'),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Confirm'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

