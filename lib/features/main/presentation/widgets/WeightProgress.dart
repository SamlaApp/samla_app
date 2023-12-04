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
//weightprogress without catogry

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
  List<String> weightsTitles = ['', '', '', '', '', '', '', ''];
  double height = 0;
  //final Map<String, double> progresses;
  //WeightProgressState({required this.progresses});

  double currentWeight = 55;
  double currentHeight = 0;
  double currentBMI = 20;
  String currentBMICatogry = '';

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: themeDarkBlue.withOpacity(0.7),
      fontWeight: FontWeight.w300,
      fontSize: 12,
    );
    String text = weightsTitles[value.toInt()];

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<FlSpot> weightSpots = weights.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value);
    }).toList();

    return BlocBuilder<ProgressCubit, ProgressState>(
      bloc: sl<ProgressCubit>(),
      builder: (context, state) {
        if (state is ProgressLoadedState) {
          weights = getLast7DaysProgress(state.progress).values.toList();
          weightsTitles = getLast7DaysProgress(state.progress).keys.toList();
          print('weights progress after api : $weights');

          if (weights.isEmpty) {
            weights = [33, 44, 55, 66, 77, 88, 99, 100];
          }
          height = state.progress.last.height ?? 0;
          print('weights:');
          print(weights);
          // int currentWeightIndex = weights.length - 1; /
          int currentWeightIndex = weights.length - 2; //
          print('currentWeightIndex $currentWeightIndex');
          currentWeight = weights[currentWeightIndex]; //
          currentBMI = calculateBMI(currentWeight, height); //
          currentBMICatogry = getBMIcategory(currentBMI); //

          currentBMI = double.parse(currentBMI.toStringAsFixed(2));
        }
        return Container(
          padding: const EdgeInsets.all(15),
          decoration: primary_decoration,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text("$currentWeight kg",
                                      style: textStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: themePink)),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("Height",
                                      style: textStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text("$height cm",
                                      style: textStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: themePink)),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("Overall BMI",
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Text("$currentBMI",
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: themePink)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Container(
                            height: 150,
                            width: 382,
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
                                  show: false, //false
                                  getDrawingHorizontalLine: (value) {
                                    return const FlLine(
                                      color: Color(0xff37434d),
                                      strokeWidth: 1,
                                    );
                                  },
                                  drawVerticalLine: false,
                                  getDrawingVerticalLine: (value) {
                                    return const FlLine(
                                      color: Color.fromRGBO(64, 194, 210, 1),
                                      strokeWidth: 1,
                                    );
                                  },
                                ),
                                borderData: FlBorderData(
                                  show: false, //false
                                  border: Border.all(
                                      color: const Color(0xff37434d), width: 1),
                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 30,
                                      getTitlesWidget: getTitles,
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  topTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  rightTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                ),

                                lineBarsData: [
                                  LineChartBarData(
                                    spots: weightSpots,
                                    isCurved: true,
                                    color: Color.fromRGBO(219, 119, 172, 1),
                                    barWidth: 3,
                                    dotData: FlDotData(
                                      show: true,
                                      getDotPainter:
                                          (spot, percent, barData, index) {
                                        return FlDotCirclePainter(
                                          radius: 4, // Dot size
                                          color: themePink, // Dot color
                                          strokeWidth: 1,
                                          strokeColor: Colors.white,
                                        );
                                      },
                                    ),

                                    ///
                                    belowBarData: BarAreaData(
                                        show: true,
                                        color: themePink.withOpacity(0.2)),
                                  ),
                                  // ShowingTooltipIndicators: [0,1,2, ...].map((index){//couldn't do it show that ShowingTooltipIndicators does not exist
                                  //   return ShowingTooltipIndicators([
                                  //     LineBarSpot(this, 0, this.spots[index]),
                                  //   ]);
                                  // }).toList(),
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

// filteration Method
Map<String, double> getLast7DaysProgress(List<Progress> progressList) {
  final Map<String, double> last7DaysProgressMap = {};

  //List<ProgressModel> progressList = await ProgressRemoteDataSourceImpl().getAllProgress();
  print('Weight Progress progress List : $progressList');
  // Get the current date
  final currentDate = DateTime.now();

  // Iterate over the last 7 days
  for (var i = 0; i < 7; i++) {
    // Calculate the date for the current iteration
    final date = currentDate.subtract(Duration(days: i));
    print('Iteration $i - date $date');
    // Format the date to a day name (e.g., "MON", "TUE")
    final dayName =
        DateFormat('EEEE').format(date).substring(0, 3).toUpperCase();
    print('Iteration $i - dayName $dayName');

    // Find progress for the current date
    var progressForDate = progressList.where((progress) {
      return (progress.date!.year == date.year &&
          progress.date!.month == date.month &&
          progress.date!.day == date.day);
    });
    print('Iteration $i - progressForDate List : $progressForDate');

    // Store the progress for the day in the map
    if (progressForDate.isNotEmpty) {
      var x = progressForDate.first.weight!.toDouble();
      print(
          'Iteration $i - progressForDate.first.weight!.toDouble() VALUE : $x');

      last7DaysProgressMap[dayName] = progressForDate.first.weight!.toDouble();
    } else {
      last7DaysProgressMap[dayName] = 0;
      print('last7DaysProgressMap 0');
    }
  }
  print('Weight Progress last7DaysProgressMap $last7DaysProgressMap');

  return reverseMap(last7DaysProgressMap);
}

Map<String, double> reverseMap(Map<String, double> originalMap) {
  return Map.fromEntries(originalMap.entries.toList().reversed);
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
