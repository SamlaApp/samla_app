import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/common_styles.dart';

class FriendWeeklyProgress extends StatefulWidget {
  final Map<String, double> userSteps;
  final Map<String, double> friendSteps;
  final Map<String, double> userCalories;
  final Map<String, double> friendCalories;

  FriendWeeklyProgress({
    required this.userSteps,
    required this.friendSteps,
    required this.userCalories,
    required this.friendCalories,
  });

  @override
  _FriendWeeklyProgressState createState() => _FriendWeeklyProgressState();
}

class _FriendWeeklyProgressState extends State<FriendWeeklyProgress> {
  bool showSteps = true; // State to track what data to show

  @override
  Widget build(BuildContext context) {
    Map<String, double> userProgress =
        showSteps ? widget.userSteps : widget.userCalories;
    Map<String, double> friendProgress =
        showSteps ? widget.friendSteps : widget.friendCalories;

    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Weekly Progress",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.directions_walk,
                      color: showSteps ? themeBlue : Colors.grey,
                    ),
                    onPressed: () => setState(() => showSteps = true),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.local_fire_department,
                      color: showSteps ? Colors.grey : Colors.red,
                    ),
                    onPressed: () => setState(() => showSteps = false),
                  ),
                ],
              ),
            ],
          ),
          Divider(),
          Expanded(
            child: BarChart(
              BarChartData(
                barTouchData: _barTouchData,
                titlesData: _titlesData,
                borderData: _borderData,
                barGroups: _barGroups(userProgress, friendProgress),
                gridData: FlGridData(show: false),
                alignment: BarChartAlignment.spaceBetween,
                maxY: _maxY(userProgress, friendProgress),
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(
            // two circles for user and friend each with the color of their data
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "You",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 8),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: themeBlue,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'VS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                "Friend",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: themePink,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  double _maxY(
      Map<String, double> userProgress, Map<String, double> friendProgress) {
    List<double> allValues =
        userProgress.values.toList() + friendProgress.values.toList();
    return allValues.reduce(max);
  }

  BarTouchData get _barTouchData => BarTouchData(
        touchTooltipData: BarTouchTooltipData(
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
              TextStyle(
                color: themeDarkBlue,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData get _titlesData {
    List<String> daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (double value, TitleMeta meta) {
            int index = value.toInt();
            if (index >= 0 && index < daysOfWeek.length) {
              return SideTitleWidget(
                meta: meta,
                space: 8.0, // or any other space value
                child: Text(daysOfWeek[index]),
              );
            }
            return Container();
          },
          reservedSize: 30,
        ),
      ),
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  FlBorderData get _borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> _barGroups(
      Map<String, double> userProgress, Map<String, double> friendProgress) {
    List<BarChartGroupData> groups = [];
    List<String> daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    userProgress.forEach((day, value) {
      int index = daysOfWeek.indexOf(day);
      if (index != -1) {
        groups.add(BarChartGroupData(
          x: index, // Use index as x value
          barRods: [
            BarChartRodData(
              width: 7,
              toY: value,
              color: themeBlue,
            ),
            BarChartRodData(
              width: 7,
              toY: friendProgress[day] ?? 0,
              color: themePink,
            ),
          ],
        ));
      }
    });
    return groups;
  }
}
