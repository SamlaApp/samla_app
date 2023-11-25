import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'dart:math';

class WeightProgress extends StatefulWidget {
  // const WeightProgress({super.key, required double weight});
  const WeightProgress({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => WeightProgressState();
}

class WeightProgressState extends State<WeightProgress> {
  final List<double> weight = [54, 34, 77, 83, 82, 90, 66, 106];

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> weightSpots = weight.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value);
    }).toList();

    return AspectRatio(
      aspectRatio: 1.65,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
        decoration: primary_decoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Weight",
                    style: textStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const Spacer(),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  width: 80,
                  child: Column(
                    children: [
                      Text(
                        '170 cm', //should get the height here!
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
                        '17.8 BMI',
                        style: textStyle.copyWith(
                          //should get the BMI here!
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: themePink,
                        ),
                      ),
                      Text(
                        'Overweight',
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
            /*
            // LineChart(
            //   LineChartData(
            //     minX: 0,
            //     maxX: weight.length - 1, //adjust to match number of data point
            //     minY: 0,
            //     maxY: weight
            //         .reduce(max)
            //         .toDouble(), //Find the maximum weight in the list //6
            //     // titlesData: LineTitles.getTitleData(),
            //     gridData: FlGridData(
            //       show: true, //false
            //       getDrawingHorizontalLine: (value) {
            //         return const FlLine(
            //           color: Color(0xff37434d),
            //           strokeWidth: 1,
            //         );
            //       },
            //       drawVerticalLine: true,
            //       getDrawingVerticalLine: (value) {
            //         return const FlLine(
            //           color: Color(0xff37434d),
            //           strokeWidth: 1,
            //         );
            //       },
            //     ),
            //     borderData: FlBorderData(
            //       show: true,
            //       border: Border.all(color: const Color(0xff37434d), width: 1),
            //     ),
            //     lineBarsData: [
            //       LineChartBarData(
            //         spots: weightSpots,
            //         isCurved: true,
            //         color: themeBlue,
            //         barWidth: 5,
            //         // dotData: FlDotData(show: false),
            //         belowBarData: BarAreaData(
            //             show: true, color: themePink.withOpacity(0.3)),
            //       ),
            //     ],
            //   ),
            // ),

             */
          ],
        ),
      ),
    );
  }
}

void main(List<String> args) {
  const WeightProgress();
}
