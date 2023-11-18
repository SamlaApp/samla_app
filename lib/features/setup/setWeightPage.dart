import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/setup/setStepsGoalPage.dart';
import 'package:samla_app/features/setup/userMeasurment.dart';
import 'package:numberpicker/numberpicker.dart';



class SetWeightPage extends StatefulWidget {
  const SetWeightPage({Key? key}) : super(key: key);
  @override
  _SetWeightPageState createState() => _SetWeightPageState();
}

class _SetWeightPageState extends State<SetWeightPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int intWeightValue = 55;
  // int _firstDigitController = 55;
  // int _secoundDigitController = 0;
  // int _thirdDigitController = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme_red,
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
        backgroundColor: theme_red,
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
                      'images/SelectWeight-pic.png',
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
                    "Enter your Weight",
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
                      minValue: 20,
                      maxValue: 199,
                      value: intWeightValue,
                      onChanged: (newValue) {
                        setState(
                          () {
                            intWeightValue = newValue;
                            // final userProgress = userMeasurment();
                            // userProgress.updateheight(height: intWeightValue);
                            // value = _firstDigitController;
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
                        userProgress.updateheight(height: intWeightValue);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SetStepsGoalPage(),
                          ),
                        );
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
