import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/features/nutrition/data/models/nutritionPlan_model.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/TodayPlan/todayPlan_cubit.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/nutrtiionPlan/nutritionPlan_cubit.dart';
import 'package:samla_app/features/nutrition/presentation/pages/MealAdapt.dart';
import 'package:samla_app/features/nutrition/presentation/pages/NewMeal.dart';
import 'package:samla_app/features/nutrition/nutrition_di.dart' as di;

class NutritionPlan extends StatefulWidget {
  const NutritionPlan({Key? key}) : super(key: key);

  @override
  _NutritionPlanState createState() => _NutritionPlanState();
}

class _NutritionPlanState extends State<NutritionPlan> {
  final cubit = di.sl.get<NutritionPlanCubit>();
  final todayPlanCubit = di.sl.get<TodayPlanCubit>();

  @override
  void initState() {
    super.initState();
    cubit.getAllNutritionPlans();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void refresh() {
    setState(() {
      cubit.getAllNutritionPlans();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nutrition Plan",
          style: TextStyle(
              color: white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Cairo'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NewMeal(),
                ),
              );
            },
          ),
        ],
        flexibleSpace: AnimateGradient(
          primaryBegin: Alignment.topLeft,
          primaryEnd: Alignment.bottomLeft,
          secondaryBegin: Alignment.bottomRight,
          secondaryEnd: Alignment.topLeft,
          primaryColors: const [
            themeBlue,
            Colors.blueAccent,
          ],
          secondaryColors: const [themeBlue, Color.fromARGB(255, 120, 90, 255)],
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Nutrition Plans',
                  style: TextStyle(
                      color: themeDarkBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, color: themeDarkBlue),
                  onPressed: () {
                    refresh();
                  },
                ),
              ],
            ),
          ), // refresh button
          buildBlocBuilder(),
        ],
      )),
    );
  }

  BlocBuilder<NutritionPlanCubit, NutritionPlanState> buildBlocBuilder() {
    return BlocBuilder<NutritionPlanCubit, NutritionPlanState>(
      bloc: cubit,
      builder: (context, state) {
        todayPlanCubit.getTodayNutritionPlan(DateFormat('EEEE').format(DateTime.now()));
        if (state is NutritionPlanLoadingState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                color: themeBlue,
                backgroundColor: themePink,
              ),
            ),
          );
        } else if (state is NutritionPlanLoaded) {
          return GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            physics: const NeverScrollableScrollPhysics(
                parent: BouncingScrollPhysics()
            ),
            itemCount: state.nutritionPlans.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              return buildNutritionPlansList(
                  state.nutritionPlans.cast<NutritionPlanModel>(), true)[index];
            },
          );
        } else if (state is NutritionPlanEmptyState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No nutrition plans found'),
            ),
          );
        } else if (state is NutritionPlanErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is NutritionPlanCreated) {
          cubit.getAllNutritionPlans();
        }
        else if (state is NutritionPlanDeleted) {
          cubit.getAllNutritionPlans();
        }
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                color: themeBlue,
                backgroundColor: themePink,
              ),
            ),
          );
      },
    );
  }

  buildNutritionPlansList(List<NutritionPlanModel> nutritionPlans, bool bool) {
    return nutritionPlans
        .map(
          (nutritionPlan) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: mealCard(nutritionPlan: nutritionPlan),
          ),
        )
        .toList();
  }

  Widget mealCard({required NutritionPlanModel nutritionPlan}) {
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

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealAdapt(nutritionPlan: nutritionPlan),
          ),
        ).then((_) {
          refresh();
        });
      },
      child: Card(
        margin: const EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 50),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    nutritionPlan.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    //time,
                    '${nutritionPlan.start_time} - ${nutritionPlan.end_time}',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8), fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
