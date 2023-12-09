// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart'
    as authDI;
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:samla_app/features/profile/presentation/widgets/AppBar_Widget01.dart';
import 'package:samla_app/features/friends/presentation/widgets/friendProfile_widget.dart';
import 'package:samla_app/features/profile/profile_di.dart' as di;

import '../../../../core/widgets/image_viewer.dart';
import '../../../main/presentation/widgets/WeeklyProgress.dart';

class FriendProfilePage extends StatefulWidget {
  const FriendProfilePage({super.key});

  @override
  State<FriendProfilePage> createState() => _FriendProfilePageState();
}

class _FriendProfilePageState extends State<FriendProfilePage> {
  final authBloc = authDI.sl.get<AuthBloc>();
  final profileCubit = di.sl.get<ProfileCubit>();
  final _baseImageUrl = 'https://chat.mohsowa.com/api/image';

  @override
  Widget build(BuildContext context) {
    final user = authDI.getUser();

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
                    imageURL: _baseImageUrl + (user.photoUrl ?? ''),
                    // Use empty string as default if photoUrl is null
                    width: 130,
                    height: 130,
                  ),
                ),
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
