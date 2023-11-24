import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'dart:math';


class _BarChart extends StatelessWidget {
  final List<double> values;
  final double maxValue;
  const _BarChart({required this.values, required this.maxValue});

  @override
  Widget build(BuildContext context) {
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
        maxY: maxValue,
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
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'SUN';
        break;
      case 1:
        text = 'MON';
        break;
      case 2:
        text = 'TUE';
        break;
      case 3:
        text = 'WED';
        break;
      case 4:
        text = 'THU';
        break;
      case 5:
        text = 'FRI';
        break;
      case 6:
        text = 'SAT';
        break;
      default:
        text = '';
        break;
    }
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

class WeeklyProgress extends StatefulWidget {
  const WeeklyProgress({super.key});

  @override
  State<StatefulWidget> createState() => WeeklyProgressState();
}

class WeeklyProgressState extends State<WeeklyProgress> {
  String dropdownValue = 'STEPS';
  final List<double> stepsValues = [1000, 2040, 3000, 1500, 500, 1800, 90];
  final List<double> caloriesValues = [300, 230, 540, 46, 450, 220, 110];
  final  List<double> distanceValues = [10, 1, 14, 7, 5, 12, 17];

  @override
  Widget build(BuildContext context) {
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
                    underline: DropdownButtonHideUnderline(child: Container()),
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
                    items: <String>['STEPS', 'CALORIES', 'DISTANCE']
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
                              color: themeDarkBlue.withOpacity(0.3)
                              ,
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
              (){
                if (dropdownValue == 'STEPS') {
                  return Expanded(
                      child: _BarChart(
                          values: stepsValues, maxValue: stepsValues.reduce(max)));
                } else if (dropdownValue == 'CALORIES') {
                  return Expanded(
                      child: _BarChart(
                          values: caloriesValues, maxValue: caloriesValues.reduce(max)));
                } else {
                  return Expanded(
                      child: _BarChart(
                          values: distanceValues, maxValue: distanceValues.reduce(max)));
                }
              }(),
  
            ],
          )),
    );
  }
}
