import 'package:flutter/material.dart';
import 'package:samla_app/features/training/presentation/widgets/startTraining/history.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../config/themes/new_style.dart';
import '../../domain/entities/ExerciseLibrary.dart';
import '../cubit/History/history_cubit.dart';

class ExerciseInfoStartPage extends StatefulWidget {
  final String name;
  final String gifUrl;
  final String bodyPart;
  final String equipment;
  final String target;
  final List<String> secondaryMuscles;
  final String instructions;
  final HistoryCubit historyCubit;
  final ExerciseLibrary selectedExercise;

  const ExerciseInfoStartPage({
    super.key,
    required this.gifUrl,
    required this.bodyPart,
    required this.equipment,
    required this.target,
    required this.secondaryMuscles,
    required this.instructions,
    required this.name,
    required this.historyCubit,
    required this.selectedExercise,
  });

  @override
  ExerciseInfoStartPageState createState() => ExerciseInfoStartPageState();
}

class ExerciseInfoStartPageState extends State<ExerciseInfoStartPage> {
  bool _isExpanded = false;
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: primaryDecoration.copyWith(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      width: MediaQuery.of(context).size.width * 0.95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              // 30% of screen hight
              height: MediaQuery.of(context).size.height * 0.26,
              child: PageView(
                controller: _pageController,
                children: [
                  Image.network(
                    widget.gifUrl,
                    // max hight is 16% of screen hight
                    height: MediaQuery.of(context).size.height * 0.16,
                    fit: BoxFit.fitHeight,
                  ),
                  GridView.count(
                    // disable GridView's scrolling
                    physics: const NeverScrollableScrollPhysics(),
                    // to disable GridView's scrolling
                    shrinkWrap: false,
                    // Use this to fit the grid within the PageView
                    crossAxisCount: 2,
                    // Number of columns
                    childAspectRatio: 23 / 14,
                    // Adjust the size ratio
                    crossAxisSpacing: 10,
                    // Horizontal space between items
                    mainAxisSpacing: 10,
                    // Vertical space between items
                    children: [
                      customBorderContainer('Body Part', widget.bodyPart),
                      customBorderContainer('Equipment', widget.equipment),
                      customBorderContainer('Target', widget.target),
                      customBorderContainer('Secondary Muscles',
                          widget.secondaryMuscles.join(', ')),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController, // your PageController
                count: 2, // the total number of pages in the PageView
                effect: const ExpandingDotsEffect(
                  expansionFactor: 4,
                  // the expansion factor of the active dot
                  spacing: 8,
                  // the space between dots
                  radius: 4,
                  // the radius of each dot
                  dotWidth: 6,
                  // the width of each dot
                  dotHeight: 6,
                  // the height of each dot
                  paintStyle: PaintingStyle.fill,
                  // style of the dot
                  strokeWidth: 1.5,
                  // the stroke width of the dot
                  activeDotColor: themeBlue,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 1,
            thickness: 0.5,
            indent: 10,
            endIndent: 10,
          ),
          ListTile(
            title: Text(
              'Instructions of ${widget.name}',
              style: TextStyle(
                color: themeGrey,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              // Use this to constrain the width of the Row
              children: [
                IconButton(
                  icon: _isExpanded
                      ? const Icon(Icons.expand_less)
                      : const Icon(Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.history),
                  // Replace with your history icon
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => HistoryDialog(
                        historyCubit: widget.historyCubit,
                        selectedExercise: widget.selectedExercise,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          if (_isExpanded)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 8, 16),
                child: buildNumberedList(
                  widget.instructions,
                  TextStyle(
                    fontSize: 12,
                    color: themeGrey,
                    fontWeight: FontWeight.normal,
                    overflow: TextOverflow.visible,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildNumberedList(String instructions, TextStyle textStyle) {
    final lines =
        instructions.split('\n').where((line) => line.trim().isNotEmpty);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        final index = lines.toList().indexOf(line) + 1;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$index.',
              style: textStyle,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                line,
                style: textStyle,
                softWrap: true,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget customBorderContainer(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: themeDarkBlue.withOpacity(.5), width: 0.9),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              gradient: LinearGradient(
                colors: [themeBlue, themeDarkBlue],
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(height: 5), // Space between label and value
          Text(
            capitalize(value),
            style: TextStyle(
              color: themeDarkBlue.withOpacity(0.7),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
