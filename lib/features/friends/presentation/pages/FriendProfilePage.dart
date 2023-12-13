// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart'
    as authDI;
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/main/home_di.dart';
import 'package:samla_app/features/main/presentation/cubits/ProgressCubit/progress_cubit.dart';
import 'package:samla_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:samla_app/features/profile/presentation/widgets/AppBar_Widget01.dart';
import 'package:samla_app/features/friends/presentation/widgets/friendProfile_widget.dart';
import 'package:samla_app/features/profile/profile_di.dart' as di;

import '../../../../core/widgets/image_viewer.dart';

import '../widgets/Progress.dart';

class FriendProfilePage extends StatefulWidget {
  const FriendProfilePage({super.key, required this.friend});
  final User friend;

  @override
  State<FriendProfilePage> createState() => _FriendProfilePageState();
}

class _FriendProfilePageState extends State<FriendProfilePage> {
  final authBloc = authDI.sl.get<AuthBloc>();
  final profileCubit = di.sl.get<ProfileCubit>();
  final _baseImageUrl = 'https://chat.mohsowa.com/api/image';
  Map<String, double> userProgress = {
    'Mon': 0,
    'Tue': 0,
    'Wed': 0,
    'Thu': 0,
    'Fri': 0,
    'Sat': 0,
    'SUN': 0,
  };
  Map<String, double> friendProgress = {
    'Mon': 0,
    'Tue': 0,
    'Wed': 0,
    'Thu': 0,
    'Fri': 0,
    'Sat': 0,
    'SUN': 0,
  };
  Map<String, double> userCalories = {
    'Mon': 0,
    'Tue': 0,
    'Wed': 0,
    'Thu': 0,
    'Fri': 0,
    'Sat': 0,
    'SUN': 0,
  };
  Map<String, double> friendCalories = {
    'Mon': 0,
    'Tue': 0,
    'Wed': 0,
    'Thu': 0,
    'Fri': 0,
    'Sat': 0,
    'SUN': 0,
  };
  bool dummy = false;
  final user = authDI.getUser();
  final progressCubit = sl<ProgressCubit>();

  @override
  void initState() {
    super.initState();
    retrive();
  }

  retrive() async {
    final Map<String, double> _userProgress = {};
    final Map<String, double> _userCalories = {};
    await progressCubit.getFriendProgress(int.parse(authBloc.user.id!),
        (progresses) {
      for (var progress in progresses) {
        // final Map<String, double> userProgress = {};
        // print(progress.steps);
        print('this is the user progress ${progresses.length}');

        String day = DateFormat('E').format(progress.date!);
        day = day.substring(0, 3);

        _userProgress[day] = progress.steps!.toDouble();

        _userCalories[day] = progress.calories!.toDouble();
      }
    });
    final Map<String, double> _friendProgress = {};
    final Map<String, double> _friendCalories = {};
    await progressCubit.getFriendProgress(int.parse(widget.friend.id!),
        (progresses) {
      print('this is the friend progress ${progresses.length}');

      for (var progress in progresses) {
        // final Map<String, double> userProgress = {};
        // final Map<String, double> userCalories = {};
        String day = DateFormat('E').format(progress.date!);
        day = day.substring(0, 3);
        _friendProgress[day] = progress.steps!.toDouble();
        print('this the friend progress in ${day}');
        print(_friendProgress[day]);
        // print(friendProgress[day]);
        _friendCalories[day] = progress.calories!.toDouble();
      }
      // print(friendCalories);
      setState(() {
        dummy = dummy ? false : true;
        friendProgress = _friendProgress;
        friendCalories = _friendCalories;
        userProgress = _userProgress;
        userCalories = _userCalories;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(friendProgress);
    print(userProgress);
    return BlocBuilder<ProgressCubit, ProgressState>(
      bloc: progressCubit,
      builder: (context, state) {
        return BlocBuilder<AuthBloc, AuthState>(
          bloc: authBloc,
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Profile'),
              ),
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: ImageViewer.network(
                        placeholderImagePath: 'images/defaults/user.png',
                        imageURL: widget.friend.photoUrl ?? '',
                        // Use empty string as default if photoUrl is null
                        width: 130,
                        height: 130,
                        animationTag: 'friend${widget.friend.id}}',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildName_email(widget.friend),
                  // NumbersWidget(), => Not needed
                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        FriendWeeklyProgress(
                          userSteps: userProgress,
                          friendSteps: friendProgress,
                          userCalories: userCalories,
                          friendCalories: friendCalories,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  //-----------------------------main widgets---------------------------------------------------
  Widget buildName_email(user) => Column(children: [
        Text(
          user.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '@' + user.username,
          style: TextStyle(),
        ),
      ]);
}

//-------Widget for creating textfields with the correct parameters--------
