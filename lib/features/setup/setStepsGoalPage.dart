import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/setup/userMeasurment.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: Scaffold(
//       body: Center(
//         child: SelectStepsGoal(),
//       ),
//     ),
//   ));
// }

class SelectStepsGoal extends StatefulWidget {
  const SelectStepsGoal({Key? key}) : super(key: key);
  @override
  _SelectStepsGoalState createState() => _SelectStepsGoalState();
}

class _SelectStepsGoalState extends State<SelectStepsGoal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _stepsGoalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme_orange,
      appBar: AppBar(
        toolbarHeight: 200.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Image.asset(
              'images/Logo/White-logo.png',
              height: 60,
              width: 80,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: theme_orange,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
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
                SizedBox(height: 0),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Image.asset(
                      'images/StepsGoal-pic.png',
                      height: 300,
                      width: 400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
                Center(
                  child: Text(
                    "Now let’s set up your \n        steps goal!",
                    style: TextStyle(
                        color: theme_darkblue,
                        fontWeight: FontWeight.bold,
                        fontSize: 26),
                  ),
                ),
                const SizedBox(height: 60),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 75),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      width: 240,
                      child: CustomTextField(
                        controller: _stepsGoalController,
                        iconData: Icons.directions_walk,
                        hintText: 'Enter number of steps',
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Step Goal!';
                          }
                          if (value.contains(' ')) {
                            return 'Step Goal must not contain spaces!';
                          }
                          final isNumeric = RegExp(r'^[0-9]+$');
                          if (!isNumeric.hasMatch(value)) {
                            return 'Step Goal must contain only Numbers!';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                Center(
                  child: Container(
                    height: 67,
                    width: 67,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                        elevation: 4, //shadow
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        final userProgress = userMeasurment();
                        userProgress.updatesteps(
                            steps: int.parse(_stepsGoalController.text));
                        // Navigator.push(  //it should go to the home page
                        //   context,
                        //   MaterialPageRoute(builder: (context) => HomePage()),
                        // );
                      }, //should navegate to next page
                      // child: const Text(
                      //   '>',
                      //   style: TextStyle(
                      //     color: Color(0xFF0A2C40),
                      //     fontSize: 35,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 35,
                        color: Color(0xFF0A2C40),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;

  const CustomTextField(
      {required TextEditingController this.controller,
      required IconData this.iconData,
      required String this.hintText,
      String? Function(String?)? this.validator});

  final TextEditingController controller;
  final IconData iconData;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: theme_green,
          ),
        ),
        prefixIcon: Icon(iconData, color: Color.fromRGBO(64, 194, 210, 1)),
        hintText: hintText,
        labelText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: theme_green,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      validator: validator,
    );
  }
}
