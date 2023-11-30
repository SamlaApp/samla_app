import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'dart:math';

import 'package:samla_app/features/main/domain/entities/Progress.dart';
import 'package:samla_app/features/main/home_di.dart';
import 'package:samla_app/features/main/presentation/cubits/ProgressCubit/progress_cubit.dart';

import 'package:samla_app/features/auth/auth_injection_container.dart'
    as authDI;
import 'package:samla_app/features/main/data/datasources/local_data_source.dart';
import 'package:samla_app/features/main/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/main/data/models/Progress.dart';
import 'package:samla_app/features/setup/BMIcalculator.dart';

class WeightProgress extends StatefulWidget {
  // const WeightProgress({super.key, required double weight});
  const WeightProgress({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => WeightProgressState();
}

class WeightProgressState extends State<WeightProgress> {
  List<double> weights = [0, 0, 0, 0, 0, 0, 0, 0];
  double height = 0;

  double currentWeight = 0;
  double currentHeight = 0;
  double currentBMI = 0;
  String currentBMICatogry = '';

  @override
  Widget build(BuildContext context) {
    // final user = authDI.getUser();

    // currentWeight = user .weight == null ? 0 : user.weight as double;
    // currentHeight = user.height == null ? 0 : user.height as double;
    // getCurrentBMI = calculateBMI(currentWeight, currentHeight);
    // getCurrentBMICatogry = getBMIcategory(getCurrentBMI);

    final List<FlSpot> weightSpots = weights.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value);
    }).toList();

    return BlocBuilder<ProgressCubit, ProgressState>(
      bloc: sl<ProgressCubit>(),
      builder: (context, state) {
        if (state is ProgressLoadedState) {
          weights = getLast7DaysProgress(state.progress).values.toList();
          height = state.progress.last.height ?? 0;
          print('weights:');
          print(weights);
          int currentWeightIndex = weights.length - 1; //
          currentWeight = weights[currentWeightIndex]; //
          currentBMI = calculateBMI(currentWeight, height); //
          currentBMICatogry = getBMIcategory(currentBMI); //
        }
        return AspectRatio(
          aspectRatio: 1.65,
          // aspectRatio: 1.4,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
            decoration: primary_decoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Weight",
                    style: textStyle.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: themeDarkBlue)),
                const SizedBox(
                  height: 10,
                ),
                Text("$currentWeight kg",
                    style: textStyle.copyWith(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: themePink)),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    // Text("Weight",
                    //     style: textStyle.copyWith(
                    //         fontSize: 16, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      width: 80,
                      child: Column(
                        children: [
                          Text(
                            '$height cm', //should get the height here!
                            style: textStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: themePink,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Height',
                            style: textStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: themeDarkBlue.withOpacity(0.3),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            '$currentBMI BMI',
                            style: textStyle.copyWith(
                              //should get the BMI here!
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: themePink,
                            ),
                          ),
                          Text(
                            currentBMICatogry,
                            style: textStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: themeDarkBlue.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: weights.length -
                        1, //adjust to match number of data point
                    minY: 0,
                    maxY: weights
                        .reduce(max)
                        .toDouble(), //Find the maximum weight in the list //6
                    // titlesData: LineTitles.getTitleData(),
                    gridData: FlGridData(
                      show: true, //false
                      getDrawingHorizontalLine: (value) {
                        return const FlLine(
                          color: Color(0xff37434d),
                          strokeWidth: 1,
                        );
                      },
                      drawVerticalLine: true,
                      getDrawingVerticalLine: (value) {
                        return const FlLine(
                          color: Color(0xff37434d),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border:
                          Border.all(color: const Color(0xff37434d), width: 1),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: weightSpots,
                        isCurved: true,
                        color: themeBlue,
                        barWidth: 5,
                        // dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                            show: true, color: themePink.withOpacity(0.3)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Map<String, double> getLast7DaysProgress(List<Progress> progressList) {
  final Map<String, double> last7DaysProgressMap = {};

  // Get the current date
  final currentDate = DateTime.now();

  // Iterate over the last 7 days
  for (var i = 0; i < 7; i++) {
    // Calculate the date for the current iteration
    final date = currentDate.subtract(Duration(days: i));

    // Format the date to a day name (e.g., "MON", "TUE")
    final dayName =
        DateFormat('EEEE').format(date).substring(0, 3).toUpperCase();

    // Find progress for the current date
    var progressForDate = progressList.where((progress) {
      return progress.date!.year == date.year &&
          progress.date!.month == date.month &&
          progress.date!.day == date.day;
    });

    // Store the progress for the day in the map
    if (progressForDate.isNotEmpty) {
      last7DaysProgressMap[dayName] = progressForDate.first.weight!.toDouble();
    } else {
      last7DaysProgressMap[dayName] = 0;
    }
  }

  return last7DaysProgressMap;
}
