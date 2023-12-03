import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../../../../config/themes/new_style.dart';
import '../../../domain/entities/ExerciseLibrary.dart';
import '../../cubit/History/history_cubit.dart';
import 'package:samla_app/features/training/training_di.dart' as di;

class ProgressSection extends StatefulWidget {
  final ExerciseLibrary selectedExercise;
  final Function onAllSetsCompleted; // New callback

  const ProgressSection({
    super.key,
    required this.selectedExercise,
    required this.onAllSetsCompleted,
  });

  @override
  State<ProgressSection> createState() => _ProgressSectionState();
}

class _ProgressSectionState extends State<ProgressSection>
    with TickerProviderStateMixin {
  int wholeNumberWeight = 25; // For the integer weight picker
  double fractionalWeight = 0; // For the fractional weight picker
  double totalWeight = 0; // To store the combined weight
  int reps = 10;
  final historyCubit = di.sl.get<HistoryCubit>();

  late int kilometers = 1;
  late int meters = 50;
  int time = 10;
  double totalDistance = 0;

  int totalSets = 3; // Default number of sets
  int finishedSets = 0; // Number of sets completed

  int remainingTime = 45; // Starting time for the timer
  Timer? _timer;

  late AnimationController _animationController;
  late Animation<double>? _animation;
  bool hasShownDialog = false;
  late final Map<String, int> exerciseSets;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 45),
    );

    _animation = Tween(begin: 1.0, end: 0.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super
        .dispose(); // Dispose of the AnimationController when the widget is disposed.
  }

  @override
  void didUpdateWidget(covariant ProgressSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedExercise.id != oldWidget.selectedExercise.id) {
      setState(() {
        totalSets = 3;
        finishedSets = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (finishedSets == totalSets && !hasShownDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!hasShownDialog) {
          hasShownDialog = true; // Set the flag
          widget.onAllSetsCompleted();
        }
      });
    }
    return Container(
      margin: const EdgeInsets.only(top: 1),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
                decoration: primaryDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: buildNumber(context),
                )),
            const SizedBox(height: 20),
            Container(
                decoration: primaryDecoration,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10, top: 16, bottom: 10),
                  child: buildExerciseSection(),
                )),
          ],
        ),
      ),
    );
  }

  Widget buildExerciseSection() {
    if (widget.selectedExercise.bodyPart == 'cardio') {
      // Return pickers for cardio exercises
      return buildCardioPickers();
    } else {
      // Return pickers for non-cardio exercises
      return buildNonCardioPickers();
    }
  }

  Widget buildCardioPickers() {
    // Build and return widgets specific to cardio exercises
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.33,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [themeBlue, themeDarkBlue],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("DISTANCE",
                    style: TextStyle(color: white, fontSize: 14,  fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.12, // Adjust as needed
                      child: buildKilometersPicker(),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.22, // Adjust as needed
                      child: buildMetersPicker(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            const Text("TIME",
                style: TextStyle(
                    color: themeDarkBlue, fontSize: 17, fontFamily: 'Cairo')),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.24, // Adjust as needed
                  child: buildTimePicker(),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 10),
        Column(
          children: [
            const Text(""),
            submitButton(), // Assuming this is defined elsewhere
          ],
        ),
      ],
    );
  }

  Widget buildNonCardioPickers() {
    // Build and return widgets for non-cardio exercises
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.33,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [themeBlue, themeDarkBlue],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("WEIGHT",
                    style: TextStyle(color: white, fontSize: 14,  fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  // according to the screen width
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: numberWeightPicker(),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.22,
                  child: buildFractionalWeightPicker(),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 10),
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.33,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [themeBlue, themeDarkBlue],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("REPS",
                    style: TextStyle(color: white, fontSize: 14,  fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: buildRepsPicker(),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // show timer
            timerDisplay(),
            const SizedBox(height: 20),
            submitButton(),
          ],
        ),
      ],
    );
  }

  Widget buildNumber(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "SET $totalSets",
            style: const TextStyle(
                color: themeDarkBlue, fontSize: 17, fontFamily: 'Cairo'),
          ),
        ),
        totalSets > 1 // Check if there's more than 1 circle to delete
            ? Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                   color: themeDarkBlue,

                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      totalSets--;
                    });
                  },
                  child: const Icon(Icons.remove, color: white),
                ),
              )
            : const SizedBox(
                width: 30,
              ),
        SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.33,
          child: customBorderContainer(),
        ),
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: themeDarkBlue,
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                totalSets++;
              });
            },
            child: const Icon(
              Icons.add,
              color: Colors.white, // Set the icon color to match your needs
            ),
          ),
        ),
      ],
    );
  }

  Widget timeAndSetsSection(String numbers, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          numbers,
          // Assume theme_green is defined elsewhere
          style: const TextStyle(fontSize: 18, color: themeBlue),
        ),
        const SizedBox(
          width: 50,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 12, color: themeGrey),
        ),
      ],
    );
  }

  Widget numberWeightPicker() {
    return NumberPicker(
      value: wholeNumberWeight,
      textStyle: const TextStyle(
        color: themeDarkBlue,
        fontSize: 17,
      ),
      selectedTextStyle: const TextStyle(
        color: themeBlue,
        fontSize: 32,
      ),
      minValue: 0,
      maxValue: 200,
      // Adjust the max value as needed
      onChanged: (value) => setState(() {
        wholeNumberWeight = value;
        updateTotalWeight();
      }),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
        border: Border(
          left: BorderSide(color: themeDarkBlue, width: 1.5),
          top: BorderSide(color: themeDarkBlue, width: 1.5),
          bottom: BorderSide(color: themeDarkBlue, width: 1.5),
        ),
      ),
    );
  }

  Widget buildFractionalWeightPicker() {
    List<int> fractionalWeights = [
      0,
      25,
      50,
      75,
    ];
    int fractionalWeightInt =
        (fractionalWeight * 100).round(); // Scale and round

    // Convert fractionalWeight to int for comparison
    int index = fractionalWeights.contains(fractionalWeightInt)
        ? fractionalWeights.indexOf(fractionalWeightInt)
        : 0;
    return NumberPicker(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        border: Border(
          right: BorderSide(color: themeDarkBlue, width: 1.5),
          top: BorderSide(color: themeDarkBlue, width: 1.5),
          bottom: BorderSide(color: themeDarkBlue, width: 1.5),
        ),
      ),
      value: index,
      onChanged: (index) => setState(() {
        fractionalWeight = fractionalWeights[index] / 100.0;
        updateTotalWeight();
      }),
      minValue: 0,
      maxValue: fractionalWeights.length - 1,
      haptics: true,
      textMapper: (String value) {
        int weight = fractionalWeights[int.parse(value)];
        return weight == 0 ? '.00 kg' : '.$weight kg';
      },
      textStyle: const TextStyle(
        color: themeDarkBlue,
        fontSize: 17,
      ),
      selectedTextStyle: const TextStyle(
        color: themeBlue,
        fontSize: 27,
      ),
    );
  }

  Widget buildKilometersPicker() {
    return NumberPicker(
      value: kilometers,
      minValue: 0,
      maxValue: 99,
      // Adjust as needed
      onChanged: (value) => setState(() {
        kilometers = value;
        updateTotalDistance();
      }),
      textStyle: const TextStyle(
        color: themeDarkBlue,
        fontSize: 17,
      ),
      selectedTextStyle: const TextStyle(
        color: themeBlue,
        fontSize: 25,
      ),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
          border: Border(
            top: BorderSide(color: themeDarkBlue, width: 1.5),
            bottom: BorderSide(color: themeDarkBlue, width: 1.5),
            left: BorderSide(color: themeDarkBlue, width: 1.5),
          )),
    );
  }

  Widget buildMetersPicker() {
    List<int> meterOptions = [
      00,
      05,
      10,
      15,
      20,
      25,
      30,
      35,
      40,
      45,
      50,
      55,
      60,
      65,
      70,
      75,
      80,
      85,
      90,
      95,
    ];
    int meterIndex =
        meterOptions.contains(meters) ? meterOptions.indexOf(meters) : 0;
    return NumberPicker(
      value: meterIndex,
      minValue: 0,
      maxValue: meterOptions.length - 1,
      onChanged: (index) => setState(() {
        meters = meterOptions[index];
        updateTotalDistance();
      }),
      textMapper: (String value) {
        int meterValue = meterOptions[int.parse(value)];
        return '.${(meterValue)} km'; // Display as .1 km, .2 km, etc.
      },
      selectedTextStyle: const TextStyle(
        color: themeBlue,
        fontSize: 25,
      ),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          border: Border(
            top: BorderSide(color: themeDarkBlue, width: 1.5),
            bottom: BorderSide(color: themeDarkBlue, width: 1.5),
            right: BorderSide(color: themeDarkBlue, width: 1.5),
          )),
    );
  }

  void updateTotalDistance() {
    setState(() {
      // Convert kilometers to meters
      totalDistance = kilometers + (meters / 100);
      //print(totalDistance);
    });
  }

  void updateTotalWeight() {
    setState(() {
      totalWeight = wholeNumberWeight + fractionalWeight;
    });
  }

  Widget buildRepsPicker() {
    return NumberPicker(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: themeDarkBlue, width: 1.5),
      ),
      value: reps,
      minValue: 1,
      maxValue: 30,
      onChanged: (value) => setState(() {
        reps = value;
      }),
      textStyle: const TextStyle(
        color: themeDarkBlue,
        fontSize: 17,
      ),
      selectedTextStyle: const TextStyle(
        color: themeBlue,
        fontSize: 25,
      ),
    );
  }

  Widget buildTimePicker() {
    return NumberPicker(
      value: time,
      minValue: 0,
      maxValue: 120,
      // Assuming the time range is 1 to 120 minutes
      onChanged: (value) => setState(() {
        time = value;
      }),
      // time + ' min'
      textMapper: (String value) => '$value min',
      textStyle: const TextStyle(
        color: themeDarkBlue,
        fontSize: 17,
      ),
      selectedTextStyle: const TextStyle(
          color: themeBlue,
          // according to the screen size
          fontSize: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: themeDarkBlue, width: 1.5),
      ),
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        shape: const CircleBorder(
          side: BorderSide(
            color: themeBlue,
            width: 4,
          ),
        ),
        primary: themeDarkBlue,
      ),
      onPressed: () {
        startTimer();

        setState(() {
          finishedSets++;
        });
        if (finishedSets >= totalSets) {
          widget.onAllSetsCompleted();
        } else {
          // Show a snackbar message for all sets except the last
          const snackBar = SnackBar(
            content: Text('Great! Rest now for 45 seconds'),
            duration: Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        // Record the history based on the type of exercise
        if (widget.selectedExercise.bodyPart == 'cardio') {
          double totalDistanceKm = kilometers + (meters / 100.0);
          historyCubit.addHistory(
            set: finishedSets,
            duration: time,
            repetitions: 0,
            weight: 0,
            distance: totalDistanceKm,
            notes: 'no notes',
            exercise_library_id: widget.selectedExercise.id!,
          );
        } else {
          double combinedWeight = wholeNumberWeight + fractionalWeight;
          historyCubit.addHistory(
            set: finishedSets,
            duration: 0,
            repetitions: reps,
            weight: combinedWeight,
            distance: 0,
            notes: 'No notes',
            exercise_library_id: widget.selectedExercise.id!,
          );
        }

        // Notify the parent widget if all sets are finished
        if (finishedSets >= totalSets) {
          // Defer the callback to allow the UI to update
          Future.delayed(Duration.zero, () {
            widget.onAllSetsCompleted();
          });
        }
      },
      child: const Icon(Icons.check, size: 30, color: themeBlue),
    );
  }

  void startTimer() {
    setState(() {
      remainingTime = 45; // Reset the timer to 45 seconds
    });

    if (_animationController.isAnimating) {
      _animationController.stop();
    }

    _animationController
      ..duration = const Duration(seconds: 45)
      ..reverse(from: 1.0); // Start the animation

    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  Widget timerDisplay() {
    if (!mounted) {
      return Container();
    }
    return Container(
      constraints: const BoxConstraints(maxWidth: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: AnimatedBuilder(
                  animation: _animation!,
                  builder: (context, child) {
                    return CircularProgressIndicator(
                      value: _animation?.value,
                      color: themeDarkBlue,
                      backgroundColor: themeBlue,
                    );
                  },
                ),
              ),
              Text(
                remainingTime == 0 ? '45' : '$remainingTime',
                style: TextStyle(fontSize: 20, color: themeGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget customBorderContainer() {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 0),
      child: Container(
        // Smaller padding
        child: buildSetsRow(),
      ),
    );
  }

  Widget buildSetsRow() {
    List<Widget> setsWidgets = List.generate(totalSets, (index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            finishedSets = index + 1;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 26,
          height: 26,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [themePink, themeDarkBlue],
            ),
            shape: BoxShape.circle,
            border: Border.all(
              color: index < finishedSets ? white : Colors.grey,
              width: 2,
            ),
            color: index < finishedSets ? themeBlue : Colors.transparent,
          ),
          child: const Center(
            child: Icon(
              Icons.check,
              color: white,
              size: 15,
            ),
          ),
        ),
      );
    });

    if (totalSets <= 3) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: setsWidgets,
        ),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: setsWidgets,
        ),
      );
    }
  }
}
