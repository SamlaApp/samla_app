// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart' as authDI;
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:samla_app/features/profile/presentation/widgets/AppBar_Widget01.dart';
import 'package:samla_app/features/friends/presentation/widgets/friendProfile_widget.dart';
import 'package:samla_app/features/profile/profile_di.dart' as di;

import '../../../main/presentation/widgets/WeeklyProgress.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  final authBloc = authDI.sl.get<AuthBloc>();
  final profileCubit = di.sl.get<ProfileCubit>();

  @override
  Widget build(BuildContext context) {
    final user = authDI.getUser();

    return BlocBuilder<AuthBloc, AuthState>(
      bloc: authBloc,
      builder: (context, state) {
        return Scaffold(
          appBar: buildAAppBar(),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 10,
              ),
              FriendProfileWidget(
                imageName: '${user.photoUrl}',
                onClicked: () async {},
              ),
              SizedBox(
                height: 20,
              ),
              buildName_email(user),
              // NumbersWidget(), => Not needed
              SizedBox(
                height: 20,
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                        WeeklyProgress(),

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
