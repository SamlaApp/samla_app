import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/core/widgets/image_viewer.dart';
import 'package:samla_app/features/main/presentation/cubits/ProgressCubit/progress_cubit.dart';
import 'package:samla_app/features/main/presentation/cubits/SendProgress/send_progress_cubit.dart';
import 'package:samla_app/features/main/presentation/cubits/StreakCubit/streak_cubit.dart';
import 'package:samla_app/features/main/presentation/widgets/CircularIndicators.dart';
import 'package:samla_app/features/main/presentation/widgets/WeeklyProgress.dart';
import 'package:samla_app/features/main/home_di.dart' as di;
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/main/presentation/widgets/WeightProgress.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final user = di.sl.get<AuthBloc>().user;
  late ProgressCubit progressCubit;

  late StreakCubit streakCubit;

  @override
  void initState() {
    super.initState();
    progressCubit = di.sl.get<ProgressCubit>();
    streakCubit = di.sl.get<StreakCubit>();
    streakCubit.getStreak();
    di.sl<SendProgressCubit>().refreashProgress();
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
                fontSize: 14, fontWeight: FontWeight.w500, color: white),
          );
        } else if (state is StreakErrorState) {
          return const Text(
            '0',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: white),
          );
        } else {
          return const Text(
            '0',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: white),
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
            BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              return Container(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/Profile'),
                      child: Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 21,
                              child: ImageViewer.network(
                                imageURL: user.photoUrl,
                                width: 42,
                                height: 42,
                                placeholderImagePath: 'images/defaults/user.png',
                                viewerMode: false,
                              )),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Welcome,',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: themeDarkBlue.withOpacity(0.6),
                                ),
                              ),
                              Text(
                                user.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: themeDarkBlue.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const Spacer(
                      flex: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                themeRed,
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
                  ],
                ),
              );
            }),

            const SizedBox(height: 40),
            Wrap(direction: Axis.horizontal, runSpacing: 25, children: [
              CircularIndicators(),
              WeeklyProgress(),
              WeightProgress(),
            ]),
          ],
        ),
      ),
    );
    // persistentFooterButtons: [MainButtons()],
  }
}
