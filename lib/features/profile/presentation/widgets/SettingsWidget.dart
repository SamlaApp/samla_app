import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:io/ansi.dart';
import 'package:samla_app/features/auth/data/models/user_model.dart';
import 'package:samla_app/features/auth/presentation/pages/Login.dart';

import '../../../../config/themes/common_styles.dart';
import '../../../../core/network/samlaAPI.dart';
import '../../../auth/auth_injection_container.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../cubit/profile_cubit.dart';
import '../pages/PersonalInfo.dart';
import 'package:samla_app/features/profile/profile_di.dart' as di;


class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

final user = getUser();

class _SettingsWidgetState extends State<SettingsWidget> {
  // late User user2;
  int selectedKilograms = 70; // Initial selected kilograms
  int selectedGrams = 0; // Initial selected grams

  final List<int> kilograms =
  List.generate(200, (index) => index + 1); // 1 to 200 kilograms
  final List<int> grams =
  List.generate(10, (index) => index * 100); // 0 to 900 grams
  double calories = 0; // Initial value
  double maxCalories = 3000;
  bool isEditing = false;

  final _formKey = GlobalKey<FormState>();
  final profileCubit = di.sl.get<ProfileCubit>();

  // Define controllers for the form fields and set initial values
  final TextEditingController _nameController =
  TextEditingController(text: user.name);
  final TextEditingController _emailController =
  TextEditingController(text: user.email);
  final TextEditingController _userNameController =
  TextEditingController(text: user.username);
  final TextEditingController _phoneController =
  TextEditingController(text: user.phone);
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();


  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();

    super.dispose();
  }

  Future<void> _saveInfo() async {
    // You can handle saving data here
    final name = _nameController.text;
    final userName = _userNameController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    final  newPass = _newPassController.text.trim();
    final  confirmPass = _newPassController.text.trim();

    if (newPass.isNotEmpty && confirmPass.isNotEmpty) {
      print('I entered in the condition of new password');
      // Validate and update password
      await profileCubit.updatePassword(newPass, confirmPass);
    }

    UserModel userModel = UserModel.fromEntity(user.copyWith(
        name: name, username: userName, email: email, phone: phone)
    );

    await profileCubit.updateUserSetting(userModel);

    print('Name: $name');
    print('UserName: $userName');
    print('Email: $email');
    print('Phone: $phone');
    print('Pass: $newPass');
    print('Pass: $confirmPass');
    _showSuccessDialog();

  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Your setting information updated'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  Future<void> _deactiveAcount() async {
    // Call the deactivate account function
    print('im in the delete action');
    await profileCubit.deleteUser();
    authBloc.add(LogOutEvent(context));

    profileCubit.onAccountDeactivated = () {
    };
  }

  void _showDeactivateConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to deactivate your account?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Call the deactivate account function
                _deactiveAcount();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Deactivate'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
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
                color: themeBlue,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              decoration: textField_decoration,
              child: TextField(
                controller: _nameController,
                style: inputText,
                cursorColor: themeBlue,
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
                color: themeBlue,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              decoration: textField_decoration,
              child: TextField(
                controller: _userNameController,
                style: inputText,
                cursorColor: themeBlue,
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
                color: themeBlue,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              decoration: textField_decoration,
              child: TextField(
                controller: _emailController,
                style: inputText,
                cursorColor: themeBlue,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Icon(Icons.email,
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
                color: themeBlue,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              decoration: textField_decoration,
              child: TextField(
                controller: _phoneController,
                style: inputText,
                cursorColor: themeBlue,
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
              'New Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: themeBlue,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              decoration: textField_decoration,
              child: TextField(
                controller: _newPassController,
                style: inputText,
                cursorColor: themeBlue,
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

            SizedBox(
              height: 15,
            ),

            Text(
              'Confirm Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: themeBlue,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              decoration: textField_decoration,
              child: TextField(
                controller: _confirmPassController,
                style: inputText,
                cursorColor: themeBlue,
                decoration: InputDecoration(
                  hintText: 'Confirm your new password',
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
                    primary: themeBlue,
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
                  style: TextStyle(
                    color: Colors.white
                  ),
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
                onPressed: _showDeactivateConfirmationDialog,
                child: Text(
                  'Deactive Account',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}