import 'package:flutter/material.dart';
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
      padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
      decoration: const BoxDecoration(color: Color.fromRGBO(252, 252, 252, 1)),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        clipBehavior: Clip.none,
        child: Wrap(direction: Axis.horizontal, runSpacing: 25, children: [
          //  circular indicators
          CircularIndicators(),

          WeeklyProgress(),

        ]),
      ),
    );
    // persistentFooterButtons: [MainButtons()],
  }

}
