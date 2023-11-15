import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:numberpicker/numberpicker.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/setup/setWeightPage.dart';
import 'package:samla_app/features/setup/userMeasurment.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: Scaffold(
//       body: Center(
//         child: SetHeightPage(),
//       ),
//     ),
//   ));
// }

class SetHeightPage extends StatefulWidget {
  const SetHeightPage({Key? key}) : super(key: key);
  @override
  _SetHeightPageState createState() => _SetHeightPageState();
}

class _SetHeightPageState extends State<SetHeightPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int intHeightValue = 177;
  // int _firstDigitController = 177;
  // int _secoundDigitController = 0;
  // int _thirdDigitController = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme_green,
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
        backgroundColor: theme_green,
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
                SizedBox(height: 25),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Image.asset(
                      'images/SelectHight-pic.png',
                      height: 250,
                      width: 400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Enter your Height",
                    style: TextStyle(
                        color: theme_darkblue,
                        fontWeight: FontWeight.bold,
                        fontSize: 26),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NumberPicker(
                      textStyle: TextStyle(
                        color: theme_darkblue,
                      ),
                      textMapper: (value) => value.toString(),
                      itemWidth: 80,
                      itemHeight: 60,
                      axis: Axis.vertical,
                      selectedTextStyle: TextStyle(
                        color: theme_green,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: theme_darkblue,
                          ),
                          bottom: BorderSide(
                            color: theme_darkblue,
                          ),
                        ),
                      ),
                      minValue: 50,
                      maxValue: 199,
                      value: intHeightValue,
                      onChanged: (newValue) {
                        setState(
                          () {
                            intHeightValue = newValue;
                            // final userProgress = userMeasurment();
                            // userProgress.updateheight(height: intHeightValue);
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
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
                        userProgress.updateheight(height: intHeightValue);
                        //    Navigator.pushReplacementNamed(context,'/setWeight');
                        const SetWeightPage(); //should navegate to SetWeightPage
                      },
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
