import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/main/presentation/widgets/CircularIndicators.dart';
import 'package:samla_app/features/main/presentation/widgets/DailyChallenge.dart';
import 'package:samla_app/features/main/presentation/widgets/WeeklyProgress.dart';
import 'package:samla_app/features/main/home_di.dart' as di;
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../config/themes/common_styles.dart';
import '../cubits/ProgressCubit/progress_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final user = di.sl.get<AuthBloc>().user;
  late ProgressCubit progressCubit;

  @override
  void initState() {
    super.initState();
    di.HomeInit();
    progressCubit = di.sl.get<ProgressCubit>();
  }

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
          WeeklyProgress(),
          progressBuilder()

        ]),
      ),
    );
    // persistentFooterButtons: [MainButtons()],
  }

  BlocBuilder<ProgressCubit, ProgressState> progressBuilder() {
    progressCubit.getProgress();
    return BlocBuilder<ProgressCubit, ProgressState>(
      bloc: progressCubit,
      builder: (context, state) {
        if (state is ProgressInitial) {
          return Center(
            child: CircularProgressIndicator(
              color: theme_green,
              backgroundColor: theme_pink,
            ),
          );
        } else if (state is ProgressLoadedState) {
          return Container(
            child: Text(state.progress.toString()),
          );
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}
