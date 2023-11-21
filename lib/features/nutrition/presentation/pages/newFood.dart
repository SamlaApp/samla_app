import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:samla_app/features/nutrition/domain/entities/MealLibrary.dart';
import 'package:samla_app/features/nutrition/domain/repositories/nutritionPlan_repository.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/nutrtiionPlan/nutritionPlan_cubit.dart';
import '../../nutrition_di.dart';

class NewFoodPage extends StatefulWidget {
  const NewFoodPage({Key? key}) : super(key: key);

  @override
  _NewFoodState createState() => _NewFoodState();
}

class _NewFoodState extends State<NewFoodPage> {
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

  final cubit = sl<NutritionPlanCubit>();
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final meal = MealLibrary(
        name: _nameController.text,
        calories: _calories,
        fat: double.parse(_fatController.text),
        protein: double.parse(_proteinController.text),
        carbs: double.parse(_carbsController.text),
        serving_size_g: 100,
      );

      cubit.addMealLibrary(meal);

      // page message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Food added to meal library'),
        ),
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme_darkblue,
      appBar: AppBar(
        toolbarHeight: 150.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primary_color),
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
          decoration: BoxDecoration(
            color: primary_color,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Calories/100g',
                            style: TextStyle(
                              fontSize: 16,
                              color: theme_darkblue,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: _caloriesController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Calories',
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Carbs/100g',
                            style: TextStyle(
                              fontSize: 16,
                              color: theme_darkblue,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: _carbsController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Calories',
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Protein/100g',
                            style: TextStyle(
                              fontSize: 16,
                              color: theme_darkblue,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: _proteinController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Calories',
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Fat/100g',
                            style: TextStyle(
                              fontSize: 16,
                              color: theme_darkblue,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: _fatController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a value';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Calories',
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buttonAddCustomMeal(),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _buttonAddCustomMeal() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: theme_green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: _submitForm,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Add Food',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold, color: primary_color
            ),
          ),
        ),
      ),
    );
  }
}
