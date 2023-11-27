import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'dart:math';

import 'package:samla_app/features/main/domain/entities/Progress.dart';
import 'package:samla_app/features/main/presentation/cubits/ProgressCubit/progress_cubit.dart';

class _BarChart extends StatelessWidget {
  final Map<String, double> progresses;
  _BarChart({required this.progresses});

  @override
  Widget build(BuildContext context) {
    List<double> values = progresses.values.toList();
    
    double maxValue = values.reduce(max);
    return BarChart(
      swapAnimationDuration: Duration(milliseconds: 300),
      swapAnimationCurve: Curves.easeInOutSine,
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups(values),
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceBetween,
        maxY: maxValue.toDouble(),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              // '',
              TextStyle(
                color: themeBlue,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: themeDarkBlue.withOpacity(0.7),
      fontWeight: FontWeight.w300,
      fontSize: 12,
    );
    String text = progresses.keys.toList()[value.toInt()];

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          themePink,
          themeBlue,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> barGroups(values) {
    final double width = 15;
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            width: width,
            toY: values[0],
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            width: width,
            toY: values[1],
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            width: width,
            toY: values[2],
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            width: width,
            toY: values[3],
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
            width: width,
            toY: values[4],
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          BarChartRodData(
            width: width,
            toY: values[5],
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 6,
        barRods: [
          BarChartRodData(
            width: width,
            toY: values[6],
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      )
    ];
  }
}

Map<String, double> emptyMap = {
  'MON': 0,
  'TUE': 0,
  'WED': 0,
  'THU': 0,
  'FRI': 0,
  'SAT': 0,
  'SUN': 0,
};

class WeeklyProgress extends StatefulWidget {
  const WeeklyProgress({super.key});

  @override
  State<StatefulWidget> createState() => WeeklyProgressState();
}

class WeeklyProgressState extends State<WeeklyProgress> {
  String dropdownValue = 'STEPS';
  Map<String, double> stepsValues = emptyMap;
  Map<String, double> caloriesValues = emptyMap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgressCubit, ProgressState>(
      bloc: sl<ProgressCubit>(),
      builder: (context, state) {
        if (state is ProgressLoadedState) {
          stepsValues = getLast7DaysProgress(state.progress);
          caloriesValues = Map.fromEntries(
            stepsValues!.entries
                .map((entry) => MapEntry(entry.key, entry.value * 0.07)),
          );
        } 

        return AspectRatio(
          aspectRatio: 1.65,
          child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
              decoration: primary_decoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text("Weekly Progress",
                        style: textStyle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Spacer(),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      width: 80,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(5),
                        underline:
                            DropdownButtonHideUnderline(child: Container()),
                        icon: SvgPicture.asset(
                          'images/arrow-down.svg',
                          height: 10,
                          color: themeDarkBlue.withOpacity(0.3),
                        ),
                        alignment: Alignment.centerRight,
                        // Step 3.
                        value: dropdownValue,
                        elevation: 1,
                        // Step 4.
                        items: <String>['STEPS', 'CALORIES']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                value,
                                style: textStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: themeDarkBlue.withOpacity(0.3),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        // Step 5.
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                      ),
                    ),
                  ]),
                  SizedBox(height: 30),
                  () {
                    if (dropdownValue == 'STEPS') {
                      return Expanded(
                          child: _BarChart(progresses: stepsValues!));
                    } else {
                      return Expanded(
                          child: _BarChart(progresses: caloriesValues!));
                    }
                  }(),
                ],
              )),
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
  for (var i = 6; i >= 0; i--) {
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
      last7DaysProgressMap[dayName] = progressForDate.first.steps!.toDouble();
    } else {
      last7DaysProgressMap[dayName] = 0;
    }
  }

  return last7DaysProgressMap;
}
