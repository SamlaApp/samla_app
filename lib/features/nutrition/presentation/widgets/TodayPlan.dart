import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:samla_app/features/nutrition/data/models/nutritionPlan_model.dart';
import 'package:samla_app/features/nutrition/domain/entities/NutritionPlanStatus.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/PlanStatus/planStatus_cubit.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/TodayPlan/todayPlan_cubit.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/displayMeal/displayMeal_cubit.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/nutrtiionPlan/nutritionPlan_cubit.dart';
import 'package:samla_app/features/nutrition/nutrition_di.dart' as di;
import 'package:samla_app/features/nutrition/presentation/cubit/summary/summary_cubit.dart';
import 'package:samla_app/features/nutrition/presentation/pages/MealAdapt.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/features/nutrition/presentation/pages/NutritionPlan.dart';

class TodayPlan extends StatefulWidget {
  const TodayPlan({super.key});

  @override
  _TodayPlanState createState() => _TodayPlanState();
}

class _TodayPlanState extends State<TodayPlan> {
  final PageController _pageController =
      PageController(viewportFraction: 1, initialPage: 0, keepPage: true);

  final nutritionCubit = di.sl.get<NutritionPlanCubit>();
  final todayPlanCubit = di.sl.get<TodayPlanCubit>();
  final displayMealCubit = di.sl.get<DisplayMealCubit>();
  final statusCubit = di.sl.get<PlanStatusCubit>();
  final summaryCubit = di.sl.get<SummaryCubit>();


  String today = DateFormat('EEEE').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    todayPlanCubit.getTodayNutritionPlan(DateFormat('EEEE').format(DateTime.now()));
  }

  BlocBuilder<TodayPlanCubit, TodayPlanState> getTodayPlans(gradient) {
    return BlocBuilder<TodayPlanCubit, TodayPlanState>(
      bloc: todayPlanCubit,
      builder: (context, state) {
        if (state is TodayPlanLoadingState) {
          return const Center(
              child: CircularProgressIndicator(
            color: themeBlue,
            backgroundColor: themePink,
          ));
        } else if (state is TodayPlanLoaded) {
          statusCubit.getNutritionPlanStatus(state.nutritionPlans[0].id!);
          displayMealCubit.getNutritionPlanMeals(today, state.nutritionPlans[0].id!);
          return Stack(
            children: [
              PageView(
                onPageChanged: (index) {
                  displayMealCubit.getNutritionPlanMeals(today, state.nutritionPlans[index].id!);
                  statusCubit.getNutritionPlanStatus(state.nutritionPlans[index].id!);
                },
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
        } else if (state is TodayPlanErrorState) {
          return Center(child: Text(state.message));
        } else if (state is NutritionPlanEmptyState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'You have no nutrition plan for today',
                    style: TextStyle(
                      color: themeDarkBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeDarkBlue,
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
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: themeBlue,
            backgroundColor: themePink,
          ));
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
                const Text(
                  'Today\'s Plan',
                  style: TextStyle(
                    color: themeDarkBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.list_sharp, color: themeDarkBlue,size: 30),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NutritionPlan()));
                  },
                ),
              ],
            ),
            if (true)
              Expanded(
                child: getTodayPlans(backgroundGradient),
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
      gradient = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          themeBlue,
          Colors.blueAccent,
        ],
      );
    } else if (type == 'Lunch') {
      icon = Icons.lunch_dining;
      gradient = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [themeOrange, Colors.red],
      );
    } else if (type == 'Dinner') {
      icon = Icons.dinner_dining;
      gradient = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [themeDarkBlue, themeBlue],
      );
    } else if (type == 'Snack') {
      icon = Icons.fastfood;
      gradient = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          themePink,
          Colors.blueAccent,
        ],
      );
    }

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: gradient,
        backgroundBlendMode: BlendMode.darken,
        borderRadius: primaryDecoration.borderRadius,
        boxShadow: primaryDecoration.boxShadow,
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
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: white
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
                          color: white.withOpacity(0.7),
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

  BlocBuilder<DisplayMealCubit, DisplayMealState> displayedMeals(int id) {
    return BlocBuilder<DisplayMealCubit, DisplayMealState>(
      bloc: displayMealCubit,
      builder: (context, state) {
        if (state is DisplayMealLoadingState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                color: Colors.white70,
              ),
            ),
          );
        } else if (state is DisplayMealErrorState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Failed to load meals',
                  style: TextStyle(color: Colors.white70)),
            ),
          );
        } else if (state is DisplayMealEmptyState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No meals', style: TextStyle(color: Colors.white70)),
            ),
          );
        } else if (state is DisplayMealLoaded) {
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
                child: Text('Failed to load meals',
                    style: TextStyle(color: Colors.white70))),
          );
        }
      },
    );
  }

  BlocBuilder<PlanStatusCubit, PlanStatusState> _planStatus(int id) {

    void mealTaken() {
      final status = NutritionPlanStatus(
        nutritionPlanStatusId: id,
        status: 'Taken',
      );
      statusCubit.updateNutritionPlanStatus(status);
      statusCubit.getNutritionPlanStatus(id);
      summaryCubit.getDailyNutritionPlanSummary();

    }

    void mealSkipped() {
      final status = NutritionPlanStatus(
        nutritionPlanStatusId: id,
        status: 'Skipped',
      );
      statusCubit.updateNutritionPlanStatus(status);
      statusCubit.getNutritionPlanStatus(id);
      summaryCubit.getDailyNutritionPlanSummary();
    }

    return BlocBuilder<PlanStatusCubit, PlanStatusState>(
      bloc: statusCubit,
      builder: (context, state) {
        if (state is PlanStatusLoadingState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                color: Colors.white70,
              ),
            ),
          );
        } else if (state is PlanStatusErrorState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Failed to load status',
                  style: TextStyle(color: Colors.white70)),
            ),
          );
        } else if (state is PlanStatusEmptyState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Status Unknown',
                  style: TextStyle(color: Colors.white70)),
            ),
          );
        }

        else if (state is PlanStatusLoaded) {
          if (state.nutritionPlanStatus.status == 'pending') {
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
                        mealTaken();
                      },
                      icon: const Icon(Icons.check, color: Colors.white),
                      label: const Text('Meal Taken',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeDarkBlue,
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
                        mealSkipped();
                      },
                      icon: const Icon(Icons.close, color: themeDarkBlue),
                      label: const Text('Skip Meal',
                          style: TextStyle(color: themeDarkBlue)),
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

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(state.nutritionPlanStatus.status,
                    style: const TextStyle(color: themeDarkBlue)),
              ),
            ),
          );
        }

        else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Status Unknown',
                  style: TextStyle(color: Colors.white70)),
            ),
          );
        }
      },
    );
  }
}
