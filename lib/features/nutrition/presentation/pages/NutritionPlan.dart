import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/nutrition/data/models/nutritionPlan_model.dart';
import 'package:samla_app/features/nutrition/presentation/cubit/nutritionPlan_cubit.dart';
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

  @override
  void initState() {
    super.initState();
    cubit.getAllNutritionPlans();
  }

  @override
  void dispose() {
    // cubit.close();
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
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
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
          primaryColors: [
            theme_green,
            Colors.blueAccent,
          ],
          secondaryColors: [
            theme_green,
            const Color.fromARGB(255, 120, 90, 255)
          ],
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
                Text(
                  'Nutrition Plans',
                  style: TextStyle(
                      color: theme_darkblue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.refresh, color: theme_darkblue),
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
        print(state);
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
        } else if (state is NutritionPlanLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: buildNutritionPlansList(
                state.nutritionPlans.cast<NutritionPlanModel>(), false),
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
        }
        else if (state is NutritionPlanCreated){
          cubit.getAllNutritionPlans();
        }
        return const SizedBox.shrink();
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

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MealAdapt(nutritionPlan: nutritionPlan),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 50),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nutritionPlan.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
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
    );
  }
}
