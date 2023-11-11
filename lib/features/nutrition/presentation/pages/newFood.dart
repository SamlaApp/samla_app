import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:samla_app/features/nutrition/domain/entities/MealLibrary.dart';
import 'package:samla_app/features/nutrition/domain/repositories/nutritionPlan_repository.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/nutritionPlan/nutritionPlan_cubit.dart';
import '../../nutrition_di.dart';

class newFood extends StatefulWidget {
  const newFood({Key? key}) : super(key: key);

  @override
  _NewFoodState createState() => _NewFoodState();
}

class _NewFoodState extends State<newFood> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _carbsController = TextEditingController();
  final _proteinController = TextEditingController();
  final _fatController = TextEditingController();

  int _calories = 100;
  int _carbs = 50;
  int _protein = 30;
  int _fat = 20;

  @override
  void initState() {
    super.initState();
    _caloriesController.text = _calories.toString();
    _carbsController.text = _carbs.toString();
    _proteinController.text = _protein.toString();
    _fatController.text = _fat.toString();
  }


  void _onCarbsChanged(int value) {
    setState(() {
      _carbs = value;
      _carbsController.text = _carbs.toString();
    });
  }

  void _onProteinChanged(int value) {
    setState(() {
      _protein = value;
      _proteinController.text = _protein.toString();

    });
  }

  void _onFatChanged(int value) {
    setState(() {
      _fat = value;
      _fatController.text = _fat.toString();

    });
  }


  void _onCaloriesChanged(int value) {
    setState(() {
      _calories = value;
      _caloriesController.text = _calories.toString();
    });
  }


  final cubit = NutritionPlanCubit(sl<NutritionPlanRepository>());

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      /*
      final meal = MealLibrary(
          name: _nameController.text,
          calories: _calories,
          fat: _fat,
          protein: _protein,
          carbs: _carbs)
      ;
      
       */


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
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
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
                        'New Food',
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
                        helperText: 'e.g. Apple, Banana, Steak',
                        labelStyle: TextStyle(
                          color: theme_darkblue,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme_grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme_darkblue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme_red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 8.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Calories/100g',
                              style: TextStyle(
                                fontSize: 16,
                                color: theme_darkblue,
                              ),
                            ),
                          ),
                        ),
                        NumberPicker(
                          textStyle: TextStyle(
                            color: theme_darkblue,
                          ),
                          textMapper: (numberText) => numberText,
                          itemWidth: 60,
                          haptics: true,
                          itemHeight: 40,
                          axis: Axis.horizontal,
                          selectedTextStyle: TextStyle(
                            color: theme_green,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: theme_darkblue,
                            ),
                          ),
                          minValue: 0,
                          maxValue: 1000,
                          value: _calories,
                          onChanged: _onCaloriesChanged,
                        ),
                      ],
                    ),
                  ),
              //gg
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 8.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Carbs (g)',
                              style: TextStyle(
                                fontSize: 16,
                                color: theme_darkblue,
                              ),
                            ),
                          ),
                        ),
                        NumberPicker(
                          textStyle: TextStyle(
                            color: theme_darkblue,
                          ),
                          textMapper: (numberText) => numberText,
                          itemWidth: 60,
                          itemHeight: 40,
                          axis: Axis.horizontal,
                          selectedTextStyle: TextStyle(
                            color: theme_green,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: theme_darkblue,
                            ),
                          ),
                          minValue: 0,
                          maxValue: 1000,
                          value: _carbs,
                          onChanged: _onCarbsChanged,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 8.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Protein (g)',
                              style: TextStyle(
                                fontSize: 16,
                                color: theme_darkblue,
                              ),
                            ),
                          ),
                        ),
                        NumberPicker(
                          textStyle: TextStyle(
                            color: theme_darkblue,
                          ),
                          textMapper: (numberText) => numberText,
                          itemWidth: 60,
                          itemHeight: 40,
                          axis: Axis.horizontal,
                          selectedTextStyle: TextStyle(
                            color: theme_green,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: theme_darkblue,
                            ),
                          ),
                          minValue: 0,
                          maxValue: 1000,
                          value: _protein,
                          onChanged: _onProteinChanged,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 8.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Fats (g)',
                              style: TextStyle(
                                fontSize: 16,
                                color: theme_darkblue,
                              ),
                            ),
                          ),
                        ),
                        NumberPicker(
                          textStyle: TextStyle(
                            color: theme_darkblue,
                          ),
                          textMapper: (numberText) => numberText,
                          itemWidth: 60,
                          itemHeight: 40,
                          axis: Axis.horizontal,
                          selectedTextStyle: TextStyle(
                            color: theme_green,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: theme_darkblue,
                            ),
                          ),
                          minValue: 0,
                          maxValue: 1000,
                          value: _fat,
                          onChanged: _onFatChanged,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme_green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _submitForm,
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Add Food',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
