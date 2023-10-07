import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/core/auth/User.dart';
import 'package:samla_app/core/error/exceptions.dart';

class LoadingScreen extends StatefulWidget {
  String? nextRoute = 'auth';
  String? message = 'Loading...';
  final callBackFunction;

  LoadingScreen({Key? key, this.nextRoute, this.message, this.callBackFunction})
      : super(key: key);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with TickerProviderStateMixin {
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
    _checkCachedUserAndNavigate();

  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _checkCachedUserAndNavigate() async {
    // await Future.delayed(Duration(seconds: 12)); // for testing
    try {
      await LocalAuth.init();
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/MainPages', (Route<dynamic> route) => false);
    } on EmptyCacheException {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:50,horizontal:100),
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
                  color: theme_pink,
                  backgroundColor: theme_green,
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
                  color: theme_darkblue.withOpacity(0.7)),
            ),
          )
        ],
      ),
    );
  }
}
