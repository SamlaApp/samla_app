import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:samla_app/features/setup/SelectGenderPage.dart';
import 'package:samla_app/features/setup/setCalories.dart';
import 'package:samla_app/features/setup/setHeightPage.dart';
import 'package:samla_app/features/setup/setStepsGoalPage.dart';
import 'package:samla_app/features/setup/setWeightPage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final ProfileCubit _profileCubit = sl.get<ProfileCubit>();
  final authBloc = sl.get<AuthBloc>();
  Color appBarColor1 = theme_darkblue;
  Color appBarColor2 = theme_pink;
  final animationDuration = Duration(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: _profileCubit,
      builder: (context, state) {
        if (state is ProfileError) {
          // show error in snack bar
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          });
          _profileCubit.reset();
        }
        return BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) =>
              current is ErrorAuthState || current is AuthenticatedState,
          bloc: authBloc,
          builder: (context, state) {
            if (state is ErrorAuthState) {
              // show error in snack bar
              SchedulerBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              });
            }

            return AnimatedContainer(
              curve: Curves.easeIn,
              duration: animationDuration,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [appBarColor1, appBarColor2],
                  begin: Alignment.topLeft,
                  end: Alignment.center,
                ),
              ),
              child: Scaffold(
                // resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  toolbarHeight: 200.0,
                  //TODO: DO NOT ALLOW THE USER TO GO BACK OR ANYWHERE UNTIL HE FINISH THE SETUP
                  leading: currentPage != 0
                      ? IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            _pageController.previousPage(
                                duration: animationDuration,
                                curve: Curves.fastEaseInToSlowEaseOut);
                            setState(() {
                              appBarColor1 = theme_darkblue;
                              appBarColor2 = theme_pink;
                              currentPage = currentPage - 1;
                            });
                          })
                      : null,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Image.asset(
                        'images/Logo/White-logo.png',
                        height: 60,
                        width: 80,
                      ),
                    ],
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: SafeArea(
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      double height = constraints.maxHeight;
                      double width = constraints.maxWidth;
                      return Container(
                        height: height,
                        width: width,
                        padding: const EdgeInsets.all(15.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: PageView(
                            padEnds: false,
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _pageController,
                            children: [
                              welcomeWidget(context, height, width),
                              GenderWidget(context, height, width, (gender) {
                                _profileCubit.setGender(gender);
                                _pageController.nextPage(
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.fastEaseInToSlowEaseOut);
                                setState(() {
                                  appBarColor1 = theme_green;
                                  appBarColor2 = theme_darkblue;
                                  currentPage = 2;
                                });
                              }),
                              HeightWidget(height, width, (height) {
                                _profileCubit.setHeight(height);
                                _pageController.nextPage(
                                    duration: animationDuration,
                                    curve: Curves.fastEaseInToSlowEaseOut);
                                setState(() {
                                  appBarColor2 = Colors.blue[900]!;
                                  appBarColor1 = Colors.blue[100]!;
                                  currentPage = 3;
                                });
                              }),
                              WeightWidget(height, width, (weight) {
                                _profileCubit.setWeightTarget(weight);
                                _pageController.nextPage(
                                    duration: animationDuration,
                                    curve: Curves.fastEaseInToSlowEaseOut);
                                setState(() {
                                  appBarColor2 = theme_orange;
                                  appBarColor1 = theme_pink;
                                  currentPage = 4;
                                });
                              }),
                              CaloriesGoalWidget(height, width, (calroies) {
                                _profileCubit.setCaloriesTarget(calroies);
                                _pageController.nextPage(
                                    duration: animationDuration,
                                    curve: Curves.fastEaseInToSlowEaseOut);
                                setState(() {
                                  appBarColor2 =
                                      Color.fromARGB(255, 110, 73, 24);
                                  appBarColor1 = theme_orange;
                                  currentPage = 5;
                                });
                              }),
                              StepsGoalWidget(height, width, (stepsGoal) async {
                                await _profileCubit.setStepsTarget(stepsGoal);
                                await _profileCubit.finishSetGoals();
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/MainPages', (route) => false);
                              }),
                            ]),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget welcomeWidget(BuildContext context, double height, double width) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'images/WelcomePage-pic.png',
          height: height * 0.5,
        ),

        Column(
          children: [
            Text(
              "Welcome to Samla",
              style: TextStyle(
                  color: theme_darkblue,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Let’s start your journey now !",
              style: TextStyle(
                  color: theme_grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ), // ensure there is a space between the text and the button

        Container(
          height: 67,
          width: 67,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16),
              elevation: 4, //shadow
              backgroundColor: Colors.white,
            ),
            onPressed: () {
              _pageController.nextPage(
                  duration: animationDuration,
                  curve: Curves.fastEaseInToSlowEaseOut);
              setState(() {
                appBarColor1 = theme_pink;
                appBarColor2 = theme_green;
                currentPage = 1;
              });
            },
            child: const Icon(
              Icons.arrow_forward_ios,
              size: 35,
              color: Color(0xFF0A2C40),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
