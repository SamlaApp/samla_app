import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:io/ansi.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart';

import '../../../../config/themes/common_styles.dart';
import '../../domain/Goals.dart';
import '../cubit/profile_cubit.dart';
import '../pages/PersonalInfo.dart';
import 'package:samla_app/features/profile/profile_di.dart' as di;

class InfoWidget extends StatefulWidget {
  const InfoWidget({Key? key}) : super(key: key);

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  final _formKey = GlobalKey<FormState>();

  int calories = 0; // Initial value
  double maxCalories = 5000;
  int steps = 0;
  double maxSteps = 10000;
  bool isEditing = false;
  UserGoals? userGoals;
  final profileCubit = di.sl.get<ProfileCubit>();

  final TextEditingController _weightController = TextEditingController();

  final TextEditingController _caloriesController = TextEditingController();

  final TextEditingController _stepsController = TextEditingController();

  @override
  void dispose() {
    // _heightController.dispose();
    _weightController.dispose();
    _stepsController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    profileCubit.getGoal();
    profileCubit.stream.listen((state) {
      if (state is UserGoalloaded) {
        var goal = state.userGoal;
        _weightController.text = '${goal.targetWeight}';
        calories = goal.targetCalories!.toInt();
        _caloriesController.text = '$calories';
        steps = goal.targetSteps!.toInt();
        _stepsController.text = '$steps';
      }
    });
  }

  Future<void> _saveInfo() async {
    // You can handle saving data here// if (_formKey.currentState != null && _formKey.currentState!.validate()) {
    final weight = double.parse(_weightController.text);
    final steps = int.parse(_stepsController.text);
    final calories = int.parse(_caloriesController.text);

    // Call the respective methods to save data
    await profileCubit.setWeightTarget(weight);
    await profileCubit.setStepsTarget(steps);
    await profileCubit.setCaloriesTarget(calories);
    // }

    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Your goal information updated'),
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

  @override
  Widget build(BuildContext context) {
    profileCubit.getGoal();
    return BlocBuilder<ProfileCubit, ProfileState>(
        bloc: profileCubit,
        builder: (context, state) {
          if (state is ProfileLoading) {
            return CircularProgressIndicator();
          } else if (state is UserGoalErrorState) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            });

            return Center(child: Text('Could not fetch the user goal'));
          } else if (state is UserGoalloaded) {
            var goal = state.userGoal;
            _weightController.text = '${goal.targetWeight}';
            calories = goal.targetCalories!.toInt();
            _caloriesController.text = '$calories';
            steps = goal.targetSteps!.toInt();
            _stepsController.text = '$steps';

            return Form(
              child: Container(
                key: _formKey,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Target Weight',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: themeBlue,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                      decoration: textField_decoration,
                      child: TextFormField(
                        controller: _weightController,
                        style: inputText,
                        decoration: InputDecoration(
                          suffixText: 'kg',
                          suffixStyle: TextStyle(color: themeDarkBlue),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                            child: Icon(
                              Icons.accessibility,
                              color: Colors.black38,
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your height';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // print('Height: $value');
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Target Calories:',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: themeBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                                decoration: textField_decoration,
                                child: TextFormField(
                                  controller: _caloriesController,
                                  style: inputText,
                                  decoration: InputDecoration(
                                    suffixText: 'Calories/Day',
                                    suffixStyle: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: themeDarkBlue,
                                    ),
                                    prefixIcon: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                      child: Icon(
                                        Icons.directions_walk,
                                        color: themeBlue,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your Target calories';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    print('calories: $value');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Target Steps:',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: themeBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                                decoration: textField_decoration,
                                child: TextFormField(
                                  controller: _stepsController,
                                  style: inputText,
                                  decoration: InputDecoration(
                                    suffixText: 'Steps/Day',
                                    suffixStyle: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: themeDarkBlue),
                                    prefixIcon: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                      child: Icon(
                                        Icons.local_fire_department_sharp,
                                        color: Colors.red,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your Target steps';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    print('calories: $value');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: themeBlue,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13),
                            // Button padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8), // Button border radius
                            ),
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        onPressed: _saveInfo,
                        child: Text(
                          'Save Info',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: Text('Could not fetch the user goal'));
        });
  }
}
