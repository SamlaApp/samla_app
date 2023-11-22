import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:io/ansi.dart';

import '../../../../config/themes/common_styles.dart';
import '../pages/PersonalInfo.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  int selectedKilograms = 70; // Initial selected kilograms
  int selectedGrams = 0; // Initial selected grams

  final List<int> kilograms =
      List.generate(200, (index) => index + 1); // 1 to 200 kilograms
  final List<int> grams =
      List.generate(10, (index) => index * 100); // 0 to 900 grams
  double calories = 0; // Initial value
  double maxCalories = 3000;
  bool isEditing = false;

  // Define controllers for the form fields and set initial values
  final TextEditingController _nameController =
      TextEditingController(text: user.name);
  final TextEditingController _emailController =
      TextEditingController(text: user.email);
  final TextEditingController _userNameController =
      TextEditingController(text: user.username);
  final TextEditingController _phoneController =
      TextEditingController(text: user.phone);
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();

  final TextEditingController _ageController =
      TextEditingController(text: '30');

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _oldPassController.dispose();
    _newPassController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _saveInfo() {
    // You can handle saving data here
    final name = _nameController.text;
    final userName = _userNameController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    final age = _ageController.text;

    print('Name: $name');
    print('UserName: $userName');
    print('Email: $email');
    print('Phone: $phone');
    print('Age: $age');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          // User Info Form with initial values
          Text(
            'Full Name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: theme_green,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            decoration: textField_decoration,
            child: TextField(
              controller: _nameController,
              style: inputText,
                cursorColor: theme_green,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Icon(
                    Icons.person,
                    color: Colors.black38,
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
            'Username',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: theme_green,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            decoration: textField_decoration,
            child: TextField(
              controller: _userNameController,
              style: inputText,
              cursorColor: theme_green,
              decoration: InputDecoration(
                prefixText: '@ ',
                prefixStyle: TextStyle(
                  color: theme_grey,
                  fontWeight: FontWeight.bold,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Icon(
                    Icons.person_pin,
                    color: Colors.black38,
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
            'Email',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: theme_green,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            decoration: textField_decoration,
            child: TextField(
              controller: _emailController,
              style: inputText,
              cursorColor: theme_green,

              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Icon(
                    Icons.email,
                    color: Colors.black38,
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
            'Phone',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: theme_green,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            decoration: textField_decoration,
            child: TextField(
              controller: _phoneController,
              style: inputText,
              cursorColor: theme_green,

              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Icon(
                    Icons.phone,
                    color: Colors.black38,
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
            'Current Password',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: theme_green,

            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            decoration: textField_decoration,
            child: TextField(
              controller: _oldPassController,
              style: inputText,
              cursorColor: theme_green,

              decoration: InputDecoration(
                hintText: 'Enter your current password',
                hintStyle: TextStyle(
                  color: theme_grey,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Icon(
                    Icons.key_outlined,
                    color: Colors.black38,
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
            'New Password',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: theme_green,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            decoration: textField_decoration,
            child: TextField(
              controller: _newPassController,
              style: inputText,
              cursorColor: theme_green,

              decoration: InputDecoration(
                hintText: 'Enter your new password',
                hintStyle: TextStyle(
                  color: theme_grey,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Icon(
                    Icons.key_outlined,
                    color: Colors.black38,
                  ),
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: theme_darkblue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 13),
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
                'Save Info',
            ),
          ),
          ),

          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: theme_red,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Button border radius
                  ),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: _saveInfo,
              child: Text(
                'Deactive Account',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
