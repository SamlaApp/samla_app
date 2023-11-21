import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:countup/countup.dart';

import 'package:flutter/cupertino.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:flutter/services.dart';
import 'package:samla_app/features/nutrition/nutrition_di.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/nutrtiionPlan/nutritionPlan_cubit.dart';

class CircularIndicators extends StatefulWidget {
  CircularIndicators({super.key});

  @override
  State<CircularIndicators> createState() => _CircularIndicatorsState();
}

class _CircularIndicatorsState extends State<CircularIndicators> {

//  final cubit = sl.get<NutritionPlanCubit>();



  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?';
  int _calories = 1700;
  late bool _animation = true;
  bool _retrived = false;
  int _caloriesGoal = 4000;
  int _Burned = 2000;





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
                  percent: (_calories / _caloriesGoal) > 1 ? 1 : _calories / _caloriesGoal,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      !_animation
                          ? Text(
                        _calories.toString(),
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: theme_green),
                      )
                          : Countup(
                        begin: 0,
                        end: _calories.toDouble(),
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
                  percent: _calories * 0.07 / _Burned > 1
                      ? 1
                      : _calories * 0.07 / _Burned,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      !_animation
                          ? Text(
                        (_calories *0.07).round().toString(),
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: theme_red),
                      )
                          : Countup(
                        begin: 0,
                        end: (_calories * 0.07).round().toDouble(),
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
