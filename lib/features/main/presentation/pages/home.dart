import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/features/main/presentation/cubits/StreakCubit/streak_cubit.dart';
import 'package:samla_app/features/main/presentation/widgets/CircularIndicators.dart';
import 'package:samla_app/features/main/presentation/widgets/WeeklyProgress.dart';
import 'package:samla_app/features/main/home_di.dart' as di;
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import '../cubits/ProgressCubit/progress_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final user = di.sl.get<AuthBloc>().user;
  late ProgressCubit progressCubit;

  late  StreakCubit streakCubit;

  @override
  void initState() {
    super.initState();
    di.HomeInit();
    progressCubit = di.sl.get<ProgressCubit>();
    streakCubit = di.sl.get<StreakCubit>();
    streakCubit.getStreak();
  }

  bool dailyChallengeStatus = true;

  void deactivateDailyChallengeStatus() {
    setState(() {
      dailyChallengeStatus = false;
    });
  }

  BlocBuilder<StreakCubit, StreakState> buildStreakStatus() {
    return BlocBuilder<StreakCubit, StreakState>(
      bloc: streakCubit,
      builder: (context, state) {
        if (state is StreakLoadedState) {
          return Text(
            state.streak.toString(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: white
            ),
          );
        } else if (state is StreakErrorState) {
          return const Text(
            '0',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: white
            ),
          );
        } else {
          return const Text(
            '0',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: white
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        clipBehavior: Clip.none,
        child: Column(
          children: [

            // Welcome Container
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        'Welcome,',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: white.withOpacity(0.6),
                        ),
                      ),
                      Text(
                        user.name,
                        style:  TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: themeBlue.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),

                  // Streak Container
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          themeOrange,
                          themePink,
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                         const Icon(
                          Icons.local_fire_department,
                          color: white,
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        buildStreakStatus(),
                      ],
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),


            const Wrap(direction: Axis.horizontal, runSpacing: 25, children: [

              CircularIndicators(),
              WeeklyProgress(),

            ]),
          ],
        ),
      ),
    );
    // persistentFooterButtons: [MainButtons()],
  }

}
