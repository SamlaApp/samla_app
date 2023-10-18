import 'package:flutter/material.dart';
import 'package:samla_app/features/main/presentation/widgets/CircularIndicators.dart';
import 'package:samla_app/features/main/presentation/widgets/DailyChallenge.dart';
import 'package:samla_app/features/main/presentation/widgets/WeeklyProgress.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  bool dailyChallengeStatus = true;

  void deactivateDailyChallengeStatus() {
    setState(() {
      dailyChallengeStatus = false;
    });
  }



  @override
  Widget build(BuildContext context) {


    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
      decoration: const BoxDecoration(color: Color.fromRGBO(252, 252, 252, 1)),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        clipBehavior: Clip.none,
        child: Wrap(direction: Axis.horizontal, runSpacing: 25, children: [
          //  circular indicators
          CircularIndicators(),
          //  check if there adaily challenge
          if (dailyChallengeStatus)
            DailyChallenge(
              challengeName: 'RUNNING',
              challengeProgress: '2 Times  |  45 Min',
              challengeImage: 'images/runner.svg',
              statusUpdate: deactivateDailyChallengeStatus,
            ),
          WeeklyProgress()
        ]),
      ),
    );
    // persistentFooterButtons: [MainButtons()],
  }
}
