import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:samla_app/features/main/home_di.dart';
import 'package:samla_app/features/main/presentation/cubits/SensorCubit/steps_cubit.dart';
import 'package:samla_app/features/main/presentation/cubits/StepsLogCubit/steps_log_cubit.dart';
import 'package:samla_app/features/profile/presentation/cubit/profile_cubit.dart';
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

  late bool _animation = true;

  bool _retrived = false;

  final _sensorCubit = sl<SensorCubit>();

  final _stepsLogCubit = sl<StepsLogCubit>();
  final _profileCubit = sl<ProfileCubit>()..getGoal();
  bool firstTime = true;
  int previousSteps = 0;

  @override
  Widget build(BuildContext context) {
    int _stepsGoal = 15000;

    int _caloriresGoal = 2000;

    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: _profileCubit,
      builder: (context, state) {
        if (state is UserGoalloaded) {
          if (state.userGoal.targetSteps as int > 0) {
            _stepsGoal = state.userGoal.targetSteps as int;
          }

          if (state.userGoal.targetCalories as int > 0) {
            _caloriresGoal = state.userGoal.targetCalories as int;
          }
        }
        return BlocBuilder<StepsLogCubit, StepsLogState>(
          bloc: _stepsLogCubit,
          builder: (context, logState) {
            return BlocBuilder<SensorCubit, SensorState>(
                bloc: _sensorCubit,
                builder: (context, state) {
                  int _steps = 0;

                  if (state is SensorError) {
                    return Container(
                      decoration: primaryDecoration,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.dangerous_outlined,
                              color: themePink,
                              size: 40,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                'Sorry, we could not access to your activity recognition!',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: themeDarkBlue.withOpacity(0.7)),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    if (logState is StepsLogInitial ||
                        _stepsLogCubit.offset != -1) {
                      // print('this is the offset ${_stepsLogCubit.offset}');
                      // print('this is the prev steps ${_stepsLogCubit.steps}');
                      // print('this is the reads ${(state as SensorWorks).reads}');
                      _steps = _stepsLogCubit.steps +
                          (state as SensorWorks).reads -
                          _stepsLogCubit.offset;
                    }

                    Widget body = Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: primaryDecoration,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.41,
                          height: MediaQuery.of(context).size.width * 0.41,
                          // constraints: BoxConstraints(
                          //     minWidth: 130, maxWidth: 230, minHeight: 130, maxHeight: 230),
                          child: LayoutBuilder(
                            builder: (BuildContext context1,
                                BoxConstraints constraints) {
                              return CircularPercentIndicator(
                                animation: _animation,
                                animateFromLastPercent: true,
                                animationDuration: 1500,
                                radius: constraints.maxWidth * 0.40,
                                lineWidth: 5.0,
                                percent: (_steps / _stepsGoal) > 1
                                    ? 1
                                    : _steps / _stepsGoal,
                                center: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Countup(
                                      begin: firstTime
                                          ? 0
                                          : previousSteps.toDouble(),
                                      end: _steps.toDouble(),
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      separator: '',
                                      style: const TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.bold,
                                          color: themeBlue),
                                    ),
                                    Text(
                                      'STEPS',
                                      style: TextStyle(
                                          fontSize: 15,
                                          // fontWeight: FontWeight.bold,
                                          color:
                                              themeDarkBlue.withOpacity(0.3)),
                                    )
                                  ],
                                ),
                                progressColor: themeBlue,
                                backgroundColor: themeBlue.withOpacity(0.2),
                              );
                            },
                          ),
                        ),

                        // _______________________ CALORIES _______________________

                        Container(
                          decoration: primaryDecoration,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.41,
                          height: MediaQuery.of(context).size.width * 0.41,
                          // constraints: BoxConstraints(
                          //     minWidth: 130, maxWidth: 230, minHeight: 130, maxHeight: 230),
                          child: LayoutBuilder(builder: (BuildContext context1,
                              BoxConstraints constraints) {
                            return CircularPercentIndicator(
                              animation: _animation,
                              animateFromLastPercent: true,
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
                                  Countup(
                                    begin: firstTime
                                        ? 0
                                        : (previousSteps * 0.07)
                                            .round()
                                            .toDouble(),
                                    end: (_steps * 0.07).round().toDouble(),
                                    duration:
                                        const Duration(milliseconds: 1500),
                                    separator: '',
                                    style: const TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold,
                                        color: themePink),
                                  ),
                                  Text(
                                    'CALORIES',
                                    style: TextStyle(
                                        fontSize: 15,
                                        // fontWeight: FontWeight.bold,
                                        color: themeDarkBlue.withOpacity(0.3)),
                                  )
                                ],
                              ),
                              progressColor: themePink,
                              backgroundColor: themePink.withOpacity(0.2),
                            );
                          }),
                        ),
                      ],
                    );

                    return body;
                  }
                });
          },
        );
      },
    );
  }
}
