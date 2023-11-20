import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:samla_app/features/nutrition/data/models/nutritionPlan_model.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/nutritionPlan_cubit.dart';
import '../../nutrition_di.dart' as di;

class NewMeal extends StatefulWidget {
  const NewMeal({Key? key}) : super(key: key);

  @override
  _NewMealState createState() => _NewMealState();
}

class _NewMealState extends State<NewMeal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _selectedMealTypeController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  Time _startTime = Time(hour: 06, minute: 00);
  Time _endTime = Time(hour: 09, minute: 00);

  int _calories = 400;

  // method take _startTime or _endTime and return time in string format
  String _timeToString(Time time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  void initState() {
    super.initState();
    _selectedMealTypeController.text = 'Breakfast';
    _startTimeController.text = _startTime.toString().substring(10, 15);
    _endTimeController.text = _endTime.toString().substring(10, 15);
  }

  void _onStartTimeChanged(Time newTime) {
    setState(() {
      _startTime = newTime;
      _startTimeController.text = _startTime.toString().substring(10, 15);
    });
  }

  void _onEndTimeChanged(Time newTime) {
    setState(() {
      _endTime = newTime;
      _endTimeController.text = _endTime.toString().substring(10, 15);
    });
  }


  final cubit = di.sl.get<NutritionPlanCubit>();

  void _submitForm() {

    if (_formKey.currentState!.validate()) {
      final nutritionPlan = NutritionPlanModel(
        name: _nameController.text.trim(),
        start_time: _startTimeController.text,
        end_time: _endTimeController.text,
        type: _selectedMealTypeController.text,
      );
      cubit.createNutritionPlan(nutritionPlan);
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme_darkblue,
      appBar: AppBar(
        toolbarHeight: 150.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/Logo/2x/Icon_1@2x.png',
              height: 80,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: theme_darkblue,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.bottom,
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Text(
                          'New Meal',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: theme_darkblue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Name',
                          helperText: 'e.g. Breakfast',
                          labelStyle: TextStyle(
                            color: theme_darkblue,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: theme_grey), // normal
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: theme_darkblue), // selected
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: theme_red), // validation error
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
        
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 8.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Start Time',
                              style: TextStyle(
                                fontSize: 16,
                                color: theme_darkblue,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                showPicker(
                                  context: context,
                                  sunrise: const TimeOfDay(hour: 6, minute: 0),
                                  // optional
                                  sunset: const TimeOfDay(hour: 18, minute: 0),
                                  // optional
                                  duskSpanInMinutes: 120,
                                  // optional
                                  onChange: (value) {
                                    setState(() {
                                      _onStartTimeChanged(value);
                                    });
                                  },
                                  themeData: ThemeData(
                                    primarySwatch: Colors.pink,
                                  ),
                                  value: _startTime
                                ),
                              );
                            },
                            child:Text(
                              // display only time
                              _timeToString(_startTime),
                              style: const TextStyle(color: Color.fromRGBO(64, 194, 210, 1)),
                            ),
                          ),
                        ),
                      ],
                    ),
        
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 8.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'End Time',
                              style: TextStyle(
                                fontSize: 16,
                                color: theme_darkblue,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                showPicker(
                                  context: context,
                                  sunrise: const TimeOfDay(hour: 6, minute: 0),
                                  // optional
                                  sunset: const TimeOfDay(hour: 18, minute: 0),
                                  // optional
                                  duskSpanInMinutes: 120,
                                  // optional
                                  onChange: (value) {
                                    setState(() {
                                      _onEndTimeChanged(value);
                                    });
                                  },
                                  themeData: ThemeData(
                                    primarySwatch: Colors.pink,
                                  ),
                                  value: _endTime
                                ),
                              );
                            },
                            child: Text(
                              _timeToString(_endTime),
                              style: const TextStyle(color: Color.fromRGBO(64, 194, 210, 1)),
                            ),
                          ),
                        ),
                      ],
                    ),
        
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 8.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Meal Type',
                            style: TextStyle(
                              fontSize: 16,
                              color: theme_darkblue,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
        
                        // Buttons
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _selectedMealTypeController.text == 'Breakfast'
                                          ? theme_green
                                          : inputField_color,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _selectedMealTypeController.text = 'Breakfast';
                                      });
                                    },
                                    child: const Text('Breakfast'),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _selectedMealTypeController.text == 'Lunch'
                                          ? theme_green
                                          : inputField_color,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _selectedMealTypeController.text = 'Lunch';
                                      });
                                    },
                                    child: const Text('Lunch'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _selectedMealTypeController.text == 'Dinner'
                                          ? theme_green
                                          : inputField_color,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _selectedMealTypeController.text = 'Dinner';
                                      });
                                    },
                                    child: const Text('Dinner'),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _selectedMealTypeController.text == 'Snack'
                                          ? theme_green
                                          : inputField_color,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _selectedMealTypeController.text = 'Snack';
                                      });
                                    },
                                    child: const Text('Snack'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
        
        
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme_green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (_startTime.hour > _endTime.hour) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Start time cannot be greater than end time'),
                              ),
                            );
                          }
        
                          else if (_calories == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Calories cannot be 0'),
                              ),
                            );
                          }
        
                          else {
                            if (_formKey.currentState!.validate()) {
                              _submitForm();
                            }
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Add Meal',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
