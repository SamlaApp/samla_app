import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/core/widgets/CustomTextFormField.dart';
import 'dart:math';

import 'package:samla_app/features/main/domain/entities/Progress.dart';
import 'package:samla_app/features/main/home_di.dart';
import 'package:samla_app/features/main/presentation/cubits/ProgressCubit/progress_cubit.dart';
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

          currentBMI = double.parse(currentBMI.toStringAsFixed(2));
        }
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: primary_decoration,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text("Weight",
                                      style: textStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: themeDarkBlue)),
                                  Text("$currentWeight kg",
                                      style: textStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: themePink)),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("Height",
                                      style: textStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: themeDarkBlue)),
                                  Text("$height cm",
                                      style: textStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: themePink)),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("Overall BMI",
                                      style: textStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: themeDarkBlue)),
                                  Text("$currentBMI",
                                      style: textStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: themePink)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 150,
                            width: 350,
                            child: LineChart(
                              LineChartData(
                                minX: 0,
                                maxX: weights.length - 1,
                                //adjust to match number of data point
                                minY: 0,
                                maxY: weights.reduce(max).toDouble(),
                                //Find the maximum weight in the list //6
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
                                  border: Border.all(
                                      color: const Color(0xff37434d), width: 1),
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: weightSpots,
                                    isCurved: true,
                                    color: themeBlue,
                                    barWidth: 5,
                                    // dotData: FlDotData(show: false),
                                    belowBarData: BarAreaData(
                                        show: true,
                                        color: themePink.withOpacity(0.3)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ],
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

Widget UpdateWeight(callback(String value)) {
  final controller = TextEditingController();
  return Container(
      child: Column(
    children: [
      CustomTextFormField(
        controller: controller,
        iconData: Icons.monitor_weight_outlined,
        label: 'Weight',
        keyboardType: TextInputType.number,
        onChanged: (value) {
          // setState(() {
          //   _weight = int.parse(value);
          // });
        },
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          callback(controller.text);
        },
        child: const Text('Update'),
      ),
    ],
  ));
}
