import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/nutrition/domain/entities/MealLibrary.dart';
import 'package:samla_app/features/nutrition/domain/entities/NutritionPlanMeal.dart';
import 'package:samla_app/features/nutrition/domain/entities/nutritionPlan.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/nutrtiionPlan/nutritionPlan_cubit.dart';
import 'package:samla_app/features/nutrition/presentation/pages/newFood.dart';
import '../../../../core/widgets/CustomTextFormField.dart';
import '../widgets/MaelAdapt/DayDropdown.dart';
import '../widgets/MaelAdapt/NutrientColumn.dart';
import '../widgets/MaelAdapt/foodItem.dart';
import '../../nutrition_di.dart';

class MealAdapt extends StatefulWidget {
  const MealAdapt({Key? key, required this.nutritionPlan}) : super(key: key);
  final NutritionPlan nutritionPlan;

  @override
  _MealAdaptState createState() => _MealAdaptState(nutritionPlan);
}

class _MealAdaptState extends State<MealAdapt> {
  _MealAdaptState(this.nutritionPlan);

  final NutritionPlan nutritionPlan;
  final _searchController = TextEditingController();

  DateTime date = DateTime.now();
  String today = DateFormat('EEEE').format(DateTime.now());

  final cubit = sl.get<NutritionPlanCubit>();
  late MealLibrary mealLibrary;

  final _displayedDay = TextEditingController();

  num _totalCarbs = 0;
  num _totalProtein = 0;
  num _totalFat = 0;
  num _totalCalories = 0;
  num _totalSize = 0;

  num _calculateTotalCarbs(List<NutritionPlanMeal> nutritionPlanMeals) {
    num result = 0;
    for (var meal in nutritionPlanMeals) {
      result += meal.carbs!;
    }
    return num.parse(result.toStringAsFixed(1));
  }

  num _calculateTotalProtein(List<NutritionPlanMeal> nutritionPlanMeals) {
    num result = 0;
    for (var meal in nutritionPlanMeals) {
      result += meal.protein!;
    }
    return num.parse(result.toStringAsFixed(1));
  }

  num _calculateTotalFat(List<NutritionPlanMeal> nutritionPlanMeals) {
    num result = 0;
    for (var meal in nutritionPlanMeals) {
      result += meal.fat!;
    }
    return num.parse(result.toStringAsFixed(1));
  }

  num _calculateTotalCalories(List<NutritionPlanMeal> nutritionPlanMeals) {
    num result = 0;
    for (var meal in nutritionPlanMeals) {
      result += meal.calories!;
    }
    return num.parse(result.toStringAsFixed(1));
  }

  num _calculateTotalSize(List<NutritionPlanMeal> nutritionPlanMeals) {
    num result = 0;
    for (var meal in nutritionPlanMeals) {
      result += meal.size!;
    }
    return num.parse(result.toStringAsFixed(1));
  }

  @override
  void initState() {
    super.initState();
    _selectedDay.text = today;
    _displayedDay.text = today;
    _selectedSize.text = _selectedSizeValue.toString();
    _submitValue();
  }

  void _submitValue() {
    cubit.getNutritionPlanMeals(_displayedDay.text, nutritionPlan.id!);
  }

  final _formKey = GlobalKey<FormState>();
  final _selectedDay = TextEditingController();
  final _selectedSize = TextEditingController();

  int _selectedSizeValue = 100;

  void _onDayChanged(String value) {
    setState(() {
      _selectedDay.text = value;
    });
  }

  void _onSizeChanged(String value) {
    setState(() {
      _selectedSizeValue = int.parse(value);
      _selectedSize.text = value;
    });
  }

  num _calculateCarbs(num carbs, num size, MealLibrary mealLibrary) {
    num result = (carbs * size / 100);
    return num.parse(result.toStringAsFixed(2));
  }

  num _calculateProtein(num protein, num size, MealLibrary mealLibrary) {
    num result = (protein * size / 100);
    return num.parse(result.toStringAsFixed(2));
  }

  num _calculateFat(num fat, num size, MealLibrary mealLibrary) {
    num result = (fat * size / 100);
    return num.parse(result.toStringAsFixed(2));
  }

  num _calculateCalories(num calories, num size, MealLibrary mealLibrary) {
    num result = (calories * size / 100);
    return num.parse(result.toStringAsFixed(2));
  }

  void _addMealToPlan(MealLibrary mealLibrary) {
    if (_formKey.currentState!.validate()) {
      final nutritionPlanMeal = NutritionPlanMeal(
        nutrition_plan_id: nutritionPlan.id,
        meal_id: mealLibrary.id,
        day: _selectedDay.text,
        size: _selectedSizeValue,
      );

      cubit.addNutritionPlanMeal(nutritionPlanMeal);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Meal added to plan'),
        ),
      );
    }
  }

  BlocBuilder<NutritionPlanCubit, NutritionPlanState> getSearchedMeals(
      gradient) {
    return BlocBuilder<NutritionPlanCubit, NutritionPlanState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is NutritionPlanLoadingState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                color: theme_green,
                backgroundColor: theme_pink,
              ),
            ),
          );
        } else if (state is NutritionPlanMealLibraryLoaded) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.mealLibrary.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primary_color,
                              ),
                            ),
                            // button to add meal to plan
                            ElevatedButton.icon(
                              onPressed: () {
                                _addMealToPlan(state.mealLibrary);
                              },
                              icon: Icon(Icons.add, color: theme_darkblue),
                              label:  Text('Add'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: theme_darkblue,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  _calculateCarbs(state.mealLibrary.carbs,
                                          _selectedSizeValue, state.mealLibrary)
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Carbs',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  _calculateProtein(state.mealLibrary.protein,
                                          _selectedSizeValue, state.mealLibrary)
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Protein',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),

                            Column(
                              children: [
                                Text(
                                  _calculateFat(state.mealLibrary.fat,
                                          _selectedSizeValue, state.mealLibrary)
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Fat',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),

                            Column(
                              children: [
                                Text(
                                  _calculateCalories(state.mealLibrary.calories,
                                          _selectedSizeValue, state.mealLibrary)
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Total kcal',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),

                            // size of meal
                            Column(
                              children: [
                                Text(
                                  _selectedSizeValue.toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Size (g)',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // selected Day
                      const SizedBox(height: 10),
                      DayDropdown(
                        color: Colors.white,
                        backgroundColor: Colors.black87,
                        initialValue: today,
                        onChanged: (value) {
                          _onDayChanged(value);
                        },
                      ),

                      // selected size
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        // scrolled number picker
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 8.0),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Size (g)',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            NumberPicker(
                              textStyle: const TextStyle(
                                color: Colors.white60,
                              ),
                              textMapper: (value) => value.toString(),
                              itemWidth: 60,
                              itemHeight: 40,
                              axis: Axis.horizontal,
                              selectedTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: theme_darkblue,
                                ),
                              ),
                              minValue: 1,
                              maxValue: 500,
                              value: _selectedSizeValue,
                              onChanged: (value) {
                                setState(() {
                                  _onSizeChanged(value.toString());
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _newFoodButton(),
              ],
            ),
          );
        } else if (state is NutritionPlanEmptyState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No meals found'),
                  const SizedBox(height: 20),
                  _newFoodButton(),
                ],
              ),
            ),
          );
        } else if (state is NutritionPlanErrorState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 20),
                  _newFoodButton(),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No food to show'),
                  const SizedBox(height: 20),
                  _newFoodButton(),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String type = nutritionPlan.type;
    late IconData icon;
    late LinearGradient gradient;
    late Color color;

    if (type == 'Breakfast') {
      icon = Icons.free_breakfast;
      gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          theme_green,
          Colors.blueAccent,
        ],
      );
      color = theme_green;
    } else if (type == 'Lunch') {
      icon = Icons.lunch_dining;
      gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [theme_orange, Colors.red],
      );
      color = theme_orange;
    } else if (type == 'Dinner') {
      icon = Icons.dinner_dining;
      gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [theme_darkblue, theme_green],
      );
      color = theme_darkblue;
    } else if (type == 'Snack') {
      icon = Icons.fastfood;
      gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          theme_pink,
          Colors.blueAccent,
        ],
      );
      color = theme_pink;
    }

    BlocBuilder<NutritionPlanCubit, NutritionPlanState> displayedMeals() {
      return BlocBuilder<NutritionPlanCubit, NutritionPlanState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is NutritionPlanMealsLoadingState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircularProgressIndicator(
                  color: theme_green,
                  backgroundColor: theme_pink,
                ),
              ),
            );
          } else if (state is NutritionPlanMealLoaded) {
            _totalCarbs = _calculateTotalCarbs(state.nutritionPlanMeals);
            _totalProtein = _calculateTotalProtein(state.nutritionPlanMeals);
            _totalFat = _calculateTotalFat(state.nutritionPlanMeals);
            _totalCalories = _calculateTotalCalories(state.nutritionPlanMeals);
            _totalSize = _calculateTotalSize(state.nutritionPlanMeals);
            return Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      NutrientColumn(
                          value: _totalCarbs, label: 'Carbs', color: color),
                      NutrientColumn(
                          value: _totalProtein, label: 'Protein', color: color),
                      NutrientColumn(
                          value: _totalFat, label: 'Fat', color: color),
                      NutrientColumn(
                          value: _totalCalories,
                          label: 'Calories',
                          color: color),
                      NutrientColumn(
                          value: _totalSize, label: 'Total Size', color: color),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                for (var meal in state.nutritionPlanMeals)
                  FoodItem(
                    gradient: gradient,
                    foodName: meal.meal_name!,
                    kcal: meal.calories!,
                    fat: meal.fat!,
                    protein: meal.protein!,
                    carbs: meal.carbs!,
                    size: meal.size!,
                    onRemove: () {
                      cubit.deleteNutritionPlanMeal(meal.id!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Meal removed from plan'),
                        ),
                      );
                    },
                  ),
              ],
            );
          } else {
            return const Center(
              child: Text('No food to show'),
            );
          }
        },
      );
    }

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 200.0,
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: gradient),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  cubit.deleteNutritionPlan(nutritionPlan.id!);
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Nutrition plan deleted'),
                    ),
                  );
                },
                icon: Icon(Icons.delete),
              ),
            ),
          ],
          title: Column(
            children: [
              Icon(icon, size: 80 , color: primary_color),
              const SizedBox(height: 5),
              Text(
                nutritionPlan.name,
                style:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primary_color),
              ),
              const SizedBox(height: 10),
              Text(
                '${nutritionPlan.start_time} - ${nutritionPlan.end_time}',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: primary_color,
            labelColor: primary_color,
            unselectedLabelColor: primary_color,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w300,
            ),
            tabs: const [
              Tab(text: 'Your current plan'),
              Tab(text: 'Find more meals'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // First tab content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Form(
                      child: DayDropdown(
                        color: theme_darkblue,
                        backgroundColor: primary_color,
                        initialValue: today,
                        onChanged: (value) {
                          setState(() {
                            _displayedDay.text = value;
                            _submitValue();
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    displayedMeals(),
                  ],
                ),
              ),
            ),

            // Second tab content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      decoration: primary_decoration,
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  label: 'Search for a food',
                                  iconData: Icons.emoji_food_beverage,
                                  controller: _searchController,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.searchMealLibrary(_searchController.text);
                                },
                                icon: Container(
                                  decoration: BoxDecoration(
                                    color: primary_color, // Set your desired background color here
                                    shape: BoxShape.circle, // Makes the container circular
                                  ),
                                  child: Icon(Icons.search, color: theme_green , size: 35),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    getSearchedMeals(gradient),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _newFoodButton() {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NewFoodPage(),
          ),
        );
      },
      icon: const Icon(Icons.add),
      label: const Text('Add custom food'),
      style: ElevatedButton.styleFrom(
        foregroundColor: theme_darkblue,
        backgroundColor: primary_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
  }
}
