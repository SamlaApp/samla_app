import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:samla_app/features/nutrition/data/models/nutritionPlan_model.dart';
import 'package:samla_app/features/nutrition/domain/entities/NutritionPlanStatus.dart';
import 'package:samla_app/features/nutrition/domain/repositories/nutritionPlan_repository.dart';
import 'package:samla_app/features/nutrition/presentation/pages/MealAdapt.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../config/themes/common_styles.dart';
import '../cubit/NutritionPlan/nutritionPlan_cubit.dart';
import '../../nutrition_di.dart' as di;
import '../pages/NutritionPlan.dart';

class TodayPlan extends StatefulWidget {
  const TodayPlan({super.key});

  @override
  _TodayPlanState createState() => _TodayPlanState();
}

class _TodayPlanState extends State<TodayPlan> {
  final PageController _pageController =
      PageController(viewportFraction: 1, initialPage: 0, keepPage: true);

  final cubit = di.sl.get<NutritionPlanCubit>();

  @override
  void initState() {
    super.initState();
    cubit.getTodayNutritionPlan(DateFormat('EEEE').format(DateTime.now()));
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  BlocBuilder<NutritionPlanCubit, NutritionPlanState> getTodayPlans(gradient) {
    return BlocBuilder<NutritionPlanCubit, NutritionPlanState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is NutritionPlanInitial) {
          cubit
              .getTodayNutritionPlan(DateFormat('EEEE').format(DateTime.now()));
          return const Center(child: CircularProgressIndicator());
        } else if (state is NutritionPlanLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NutritionPlanLoaded) {
          return Stack(
            children: [
              PageView(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                children: [
                  for (var nutritionPlan in state.nutritionPlans)
                    _dailyPlanCard(
                      NutritionPlanModel.fromEntity(nutritionPlan),
                    ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: state.nutritionPlans.length,
                    effect: const JumpingDotEffect(
                      dotHeight: 6,
                      dotWidth: 6,
                      jumpScale: 3,
                      activeDotColor: Colors.white,
                      dotColor: Colors.white70,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is NutritionPlanErrorState) {
          return Center(child: Text(state.message));
        } else if (state is NutritionPlanEmptyState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'You have no nutrition plan for today',
                    style: TextStyle(
                      color: theme_darkblue,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme_darkblue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NutritionPlan()));
                    },
                    label: const Text('Create Nutrition Plan'),
                  ),
                ],
              ),
            ),
          );
        } else if (state is NutritionPlanCreated) {
          return const Center(child: Text('Nutrition plan created'));
        } else if (state is NutritionPlanMealLibraryLoaded) {
          return const Center(
              child: Text('Nutrition plan meal library loaded'));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        height: 375,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today\'s Plan',
                  style: TextStyle(
                    color: theme_darkblue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.list_sharp, color: theme_darkblue),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NutritionPlan()));
                  },
                ),
              ],
            ),
            Expanded(
              child: getTodayPlans(background_gradient),
            ),
          ],
        ));
  }

  Widget _dailyPlanCard(NutritionPlanModel nutritionPlan) {
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

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: gradient,
        backgroundBlendMode: BlendMode.multiply,
        borderRadius: primary_decoration.borderRadius,
        boxShadow: primary_decoration.boxShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(icon, color: Colors.white, size: 30),
                        const SizedBox(width: 10),
                        Text(
                          nutritionPlan.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primary_color,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                MealAdapt(nutritionPlan: nutritionPlan),
                          ),
                        );
                      },
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primary_color,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${nutritionPlan.start_time} - ${nutritionPlan.end_time}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.white70,
                  thickness: 0.5,
                ),
                const SizedBox(height: 10),
                displayedMeals(nutritionPlan.id!),
              ],
            ),

            _planStatus(nutritionPlan.id!),
          ],
        ),
      ),
    );
  }

  BlocBuilder<NutritionPlanCubit, NutritionPlanState> displayedMeals(int id) {
    String today = DateFormat('EEEE').format(DateTime.now());
    final tempCubit = di.sl.get<NutritionPlanCubit>();
    tempCubit.getNutritionPlanMeals(today, id);
    return BlocBuilder<NutritionPlanCubit, NutritionPlanState>(
      bloc: tempCubit,
      builder: (context, state) {
        if (state is NutritionPlanMealsLoadingState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                color: Colors.white70,
              ),
            ),
          );
        } else if (state is NutritionPlanMealLoaded) {
          return Column(
            children: [
              for (var meal in state.nutritionPlanMeals)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.circle,
                            color: Colors.white70, size: 10),
                        const SizedBox(width: 10),
                        Text(
                          '${meal.meal_name} (${meal.size}g)',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        ),
                      ],
                    ),
                    Text(
                      '${meal.calories} kcal',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
            ],
          );
        } else {
          return const Center(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child:
                    Text('No meals', style: TextStyle(color: Colors.white70))),
          );
        }
      },
    );
  }




  BlocBuilder<NutritionPlanCubit, NutritionPlanState> _planStatus(int id) {
    final statusCubit = di.sl.get<NutritionPlanCubit>();
    statusCubit.getNutritionPlanStatus(id);

    void _mealTaken() {
      final status = NutritionPlanStatus(
        nutritionPlanStatusId: id,
        status: 'Taken',
      );
      statusCubit.updateNutritionPlanStatus(status);
      statusCubit.getNutritionPlanStatus(id);

    }

    void _mealSkipped() {
      final status = NutritionPlanStatus(
        nutritionPlanStatusId: id,
        status: 'Skipped',
      );
      statusCubit.updateNutritionPlanStatus(status);
      statusCubit.getNutritionPlanStatus(id);

    }



    return BlocBuilder<NutritionPlanCubit, NutritionPlanState>(
      bloc: statusCubit,
      builder: (context, state) {
        if(state is NutritionPlanLoadingState){
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                color: Colors.white70,
              ),
            ),
          );
        }else if(state is NutritionPlanStatusLoaded){

          if(state.nutritionPlanStatus.status == 'pending') {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Meal Taken
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _mealTaken();
                      },
                      icon: const Icon(Icons.check, color: Colors.white),
                      label: const Text('Meal Taken',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme_darkblue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Meal Skipped
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _mealSkipped();
                      },
                      icon: Icon(Icons.close, color: theme_darkblue),
                      label: Text('Skip Meal',
                          style: TextStyle(color: theme_darkblue)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return  Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                    state.nutritionPlanStatus.status
                    , style: TextStyle(color: theme_darkblue)),
              ),
            ),
          );

        }else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                  'Status Unknown', style: TextStyle(color: Colors.white70)),
            ),
          );
        }
      },
    );
  }
}
