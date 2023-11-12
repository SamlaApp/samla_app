import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../config/themes/common_styles.dart';
import '../pages/NutritionPlan.dart';


class TodayPlan extends StatefulWidget {
  @override
  _TodayPlanState createState() => _TodayPlanState();
}

class _TodayPlanState extends State<TodayPlan> {
  final PageController _pageController = PageController(viewportFraction: 0.85);

  String _formatDate(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);

    if (dateTime.isAtSameMomentAs(today)) {
      return 'Today';
    } else if (dateTime.isAtSameMomentAs(tomorrow)) {
      return 'Tomorrow';
    } else {
      return DateFormat('EEEE, MMM d').format(dateTime);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      child: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              for (int i = 0; i < 4; i++)
                _dailyPlanCard(
                  context,
                  _formatDate(DateTime.now().add(Duration(days: i))),
                ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 15,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 4,
                effect: JumpingDotEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  jumpScale: 2,
                  activeDotColor: theme_green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dailyPlanCard(BuildContext context, String date) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: background_gradient,
        borderRadius: primary_decoration.borderRadius,
        boxShadow: primary_decoration.boxShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NutritionPlan()));
                  },
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: primary_color),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _foodItem(context, Icons.egg, 'Egg', '30 kcal'),
                _foodItem(context, Icons.coffee, 'Milk', '30 kcal'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _foodItem(context, Icons.breakfast_dining, 'Bread', '30 kcal'),
                _foodItem(context, Icons.apple, 'Apple', '30 kcal'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column _foodItem(BuildContext context, IconData icon, String foodName, String calValue) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: theme_green, size: 30),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  calValue,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
