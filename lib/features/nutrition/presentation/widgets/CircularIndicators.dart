import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:countup/countup.dart';

import 'package:flutter/cupertino.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CircularIndicators extends StatefulWidget {
  CircularIndicators({super.key});

  @override
  State<CircularIndicators> createState() => _CircularIndicatorsState();
}

class _CircularIndicatorsState extends State<CircularIndicators> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?';
  int _steps = 0;
  late bool _animation = true;
  bool _retrived = false;
  int _stepsGoal = 500;
  int _caloriresGoal = 2000;

  @override
  void initState() {
    super.initState();
    _animation = true;
    _requestPermissions(); // Ask for activity permissions.
  }

// stop animation after first build
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  // }    _animation = false;

  void onStepCount(StepCount event) {
    getTodaySteps(event.steps).then((value) => setState(() {
      _steps != 0 ? _animation = false : _animation = true;
      _steps = value;
    }));
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      // _steps = 0;
    });
  }

  Future<void> _requestPermissions() async {
    final status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      initPlatformState();
    } else {
      print('Permission denied');
    }
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  Future<int> getTodaySteps(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int todayDayNo = DateTime.now().day;
    int savedStepCount = prefs.getInt('savedStepCount') ?? 0;
    int lastDaySaved = prefs.getInt('lastDaySaved') ?? 0;
    int todaySteps = prefs.getInt('todaySteps') ?? 0;
    int lastValue = prefs.getInt('stepsLastValue') ?? 0;
    bool lastDaySavedStatus = prefs.getBool('lastDaySavedStatus') ?? false;
    prefs.setInt('stepsLastValue', value);

    // device reboot
    if (savedStepCount > value) {
      prefs.setInt('savedStepCount', 0);
      savedStepCount = 0;
    }

    // next day
    if (todayDayNo > lastDaySaved) {
      //send lastDay to server
      if (!lastDaySavedStatus) {}

      prefs.setInt('lastDaySaved', todayDayNo);
      prefs.setInt('savedStepCount', value);
      prefs.setInt('todaySteps', 0);
      savedStepCount = value;
      todaySteps = 0;
    }

    if (savedStepCount == 0 && todaySteps > value) {
      if (value < 10) {
        prefs.setInt('todaySteps', value + todaySteps);
      } else {
        prefs.setInt('todaySteps', value - lastValue + todaySteps);
      }
    } else {
      prefs.setInt('todaySteps', value - savedStepCount);
    }

    todaySteps = prefs.getInt('todaySteps') ?? 0;

    if (todaySteps > 0) {
      return todaySteps;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: primary_decoration,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.41,
          height: MediaQuery.of(context).size.width * 0.41,
          // constraints: BoxConstraints(
          //     minWidth: 130, maxWidth: 230, minHeight: 130, maxHeight: 230),
          child: LayoutBuilder(
              builder: (BuildContext context1, BoxConstraints constraints) {
                return CircularPercentIndicator(
                  animation: _animation,
                  animationDuration: 1500,
                  radius: constraints.maxWidth * 0.40,
                  lineWidth: 5.0,
                  percent: (_steps / _stepsGoal) > 1 ? 1 : _steps / _stepsGoal,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      !_animation
                          ? Text(
                        _steps.toString(),
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: theme_green),
                      )
                          : Countup(
                        begin: 0,
                        end: _steps.toDouble(),
                        duration: Duration(milliseconds: 1500),
                        separator: '',
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: theme_green),
                      ),
                      Text(
                        'Eaten',
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: theme_darkblue.withOpacity(0.7)),
                      )
                    ],
                  ),
                  progressColor: theme_green,
                  backgroundColor: theme_green.withOpacity(0.2),
                );
              }),
        ),

        SizedBox(width: 20), // This adds space of 20 logical pixels between the containers

// _______________________ Burned _______________________

        Container(
          decoration: primary_decoration,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.41,
          height: MediaQuery.of(context).size.width * 0.41,
          // constraints: BoxConstraints(
          //     minWidth: 130, maxWidth: 230, minHeight: 130, maxHeight: 230),
          child: LayoutBuilder(
              builder: (BuildContext context1, BoxConstraints constraints) {
                return CircularPercentIndicator(
                  animation: _animation,
                  animationDuration: 1500,
                  radius: constraints.maxWidth * 0.40,
                  lineWidth: 5.0,
                  percent: _steps * 0.07 / _caloriresGoal > 1
                      ? 1
                      : _steps * 0.07 / _caloriresGoal,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      !_animation
                          ? Text(
                        (_steps *0.07).round().toString(),
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: theme_red),
                      )
                          : Countup(
                        begin: 0,
                        end: (_steps * 0.07).round().toDouble(),
                        duration: Duration(milliseconds: 1500),
                        separator: '',
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: theme_red),
                      ),
                      Text(
                        'Burned',
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: theme_darkblue.withOpacity(0.3)),
                      )
                    ],
                  ),
                  progressColor: theme_red,
                  backgroundColor: theme_red.withOpacity(0.3),
                );
              }),
        ),
      ],
    );
    ;
  }
}
