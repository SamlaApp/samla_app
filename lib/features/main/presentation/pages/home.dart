import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
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
      padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
      decoration: const BoxDecoration(color: Color.fromRGBO(252, 252, 252, 1)),
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
                        'Welcome',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: theme_darkblue.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        user.name,
                        style:  TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: theme_darkblue,
                        ),
                      ),
                    ],
                  ),

                  // Streak Container
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    decoration: BoxDecoration(
                      color: theme_red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                         Icon(
                          Icons.local_fire_department,
                          color: theme_red,
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '5',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: theme_red,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),


            Wrap(direction: Axis.horizontal, runSpacing: 25, children: [

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
