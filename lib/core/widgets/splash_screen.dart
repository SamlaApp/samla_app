import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/main/home_di.dart';
import 'package:samla_app/features/notifications/notification_injection_container.dart';
import 'package:samla_app/features/nutrition/nutrition_di.dart';
import 'package:samla_app/features/profile/profile_di.dart';
import 'package:samla_app/features/setup/welcomePage.dart';
import 'package:samla_app/firebase_options.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart' as di;

class SplashScreen extends StatefulWidget {
  String? nextRoute = 'auth';
  String? message = 'Loading...';
  final callBackFunction;

  SplashScreen({Key? key, this.nextRoute, this.message, this.callBackFunction})
      : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    _dependecyInjection();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _dependecyInjection() async {
    /* put here every thing need to be initialized before the app starts
    the process here will be excuting while the loading screen is showing
    ! make sure to add await keyword if the process is async in order to finish it 
    before handling the authentication
    */

    // initlizeing notification service
    await NotificationInit();
    print('notification initlized');
    // initlizeing auth service
    await di.AuthInit();
    print('auth initlized');
    // initlizeing profile service
    ProfileInit();
    print('profile initlized');
    // initlizeing nutrition service
    nutritionInit();
    print('nutrition initlized');
    // initlizeing home featrues
    await HomeInit();
    print('home initlized');

    // await initWorkManager();
    // authentication handling

    await _checkCachedUserAndNavigate();
  }

  Future<void> _checkCachedUserAndNavigate() async {
    final authBloc = di.sl.get<AuthBloc>();
    authBloc.add(CheckCachedUserEvent(callBackFunction: (isAuth) {
      if (isAuth) {
        print(authBloc.user.hasGoal);
        if (authBloc.user.hasGoal) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/MainPages', (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => WelcomePage(),
            ),
          );
        }
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 100),
      color: primary_color,
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/Logo/2x/Icon_1@2x.png',
                  height: 60,
                ),
                SizedBox(
                  height: 40,
                ),
                LinearProgressIndicator(
                  color: themePink,
                  backgroundColor: themeBlue,
                  semanticsLabel: 'Linear progress indicator',
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Text(
              'Samla   |   صملة',
              style: textStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: themeDarkBlue.withOpacity(0.7)),
            ),
          )
        ],
      ),
    );
  }
}
