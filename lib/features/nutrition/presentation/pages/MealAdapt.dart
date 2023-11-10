import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/nutrition/domain/entities/MealLibrary.dart';
import 'package:samla_app/features/nutrition/domain/entities/nutritionPlan.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/NutritionPlan/nutritionPlan_cubit.dart';
import 'package:samla_app/features/nutrition/presentation/pages/newFood.dart';
import '../../../../core/widgets/CustomTextFormField.dart';
import '../widgets/AddMealButton.dart';
import '../widgets/MaelAdapt/DayDropdown.dart';
import '../widgets/MaelAdapt/NutrientColumn.dart';
import '../widgets/MaelAdapt/foodItem.dart';
import 'package:samla_app/features/nutrition/domain/repositories/nutritionPlan_repository.dart';
import '../../nutrition_di.dart';

class MealAdapt extends StatefulWidget {
  const MealAdapt({Key? key, required this.nutritionPlan}) : super(key: key);
  final NutritionPlan nutritionPlan;

  _MealAdaptState createState() => _MealAdaptState(nutritionPlan);
}

class _MealAdaptState extends State<MealAdapt> {
  _MealAdaptState(this.nutritionPlan);

  final NutritionPlan nutritionPlan;
  final _searchController = TextEditingController();

  final cubit = NutritionPlanCubit(sl<NutritionPlanRepository>());
  late MealLibrary mealLibrary;

  @override
  Widget build(BuildContext context) {
    String type = nutritionPlan.type;
    late IconData icon;
    late LinearGradient gradient;

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
    } else if (type == 'Lunch') {
      icon = Icons.lunch_dining;
      gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [theme_orange, Colors.red],
      );
    } else if (type == 'Dinner') {
      icon = Icons.dinner_dining;
      gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [theme_darkblue, theme_green],
      );
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
    }

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 200.0,
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: gradient),
          ),
          title: Column(
            children: [
              Icon(icon, size: 80),
              const SizedBox(height: 5),
              Text(
                nutritionPlan.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '${nutritionPlan.start_time} - ${nutritionPlan.end_time}',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: primary_color,
            unselectedLabelColor: Colors.white,
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
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
                          NutrientColumn(value: '30', label: 'Carbs'),
                          NutrientColumn(value: '24', label: 'Protein'),
                          NutrientColumn(value: '18', label: 'Fat'),
                          NutrientColumn(value: '350', label: 'Total kcal'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    DayDropdown(
                      days: const [
                        'Monday',
                        'Tuesday',
                        'Wednesday',
                        'Thursday',
                        'Friday',
                        'Saturday',
                        'Sunday'
                      ],
                      initialValue: 'Saturday',
                      onChanged: (value) {
                        print("Selected day: $value");
                      },
                    ),
                    const SizedBox(height: 20),
                    FoodItem(foodName: 'eggs', kcal: 22,fat: 22,protein: 33,carbs: 33, onRemove: () {}),


                    const SizedBox(height: 30),
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
                        // search field
                        children: [
                          // adding floating button
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  label: 'Search for a food',
                                  iconData: Icons.emoji_food_beverage,
                                  controller: _searchController,
                                ),
                              ),
                              IconButton.filled(
                                onPressed: () {
                                  cubit.searchMealLibrary(
                                      _searchController.text);
                                },
                                icon: const Icon(Icons.search),
                                color: theme_green,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    getSearchedMeals(gradient),
                    const SizedBox(height: 20),

                    AddMealButton(
               onButtonPressed: (BuildContext context) {
                  Navigator.of(context).push(
                             MaterialPageRoute(
                               builder: (context) => const newFood(),
      ),

    );
  } ),          ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
          return Column(
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
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          // button to add meal to plan
                          ElevatedButton.icon(
                            onPressed: () {

                              final MealLibrary mealToAdd = MealLibrary(
                                name: mealLibrary.name,
                                calories: mealLibrary.calories,
                                carbs: mealLibrary.carbs,
                                protein: mealLibrary.protein,
                                fat: mealLibrary.fat,

                              );
                              context.read<NutritionPlanCubit>().addMealToPlan(mealToAdd);
                            },


                            icon: const Icon(Icons.add),
                            label: const Text('Add'),
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
                                state.mealLibrary.carbs.toString(),
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
                                state.mealLibrary.protein.toString(),
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
                                state.mealLibrary.fat.toString(),
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
                                state.mealLibrary.calories.toString(),
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
                                state.mealLibrary.serving_size_g.toString(),
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
                  ],
                ),
              ),
            ],
          );
        } else if (state is NutritionPlanEmptyState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No meals found'),
            ),
          );
        } else if (state is NutritionPlanErrorState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No food to show'),
            ),
          );
        }
      },
    );
  }

}
