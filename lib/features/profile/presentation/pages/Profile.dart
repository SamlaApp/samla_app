// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart'
    as authDI;
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:samla_app/features/profile/presentation/pages/PersonalInfo.dart';
import 'package:samla_app/features/profile/presentation/widgets/AppBar_Widget01.dart';
import 'package:samla_app/features/profile/presentation/widgets/profile_widget.dart';
import 'package:samla_app/features/profile/profile_di.dart' as di;

// import '../widgets/InfoWidget01.dart';
import '../widgets/InfoWidget.dart';

import '../widgets/SettingsWidget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0; // 0: info, 1: achievements, 2: settings
  // final String imagePath = 'images/download.jpeg';

  final authBloc = authDI.sl.get<AuthBloc>();
  final profileCubit = di.sl.get<ProfileCubit>();

  @override
  Widget build(BuildContext context) {
    final user = authDI.getUser();

    return BlocBuilder<AuthBloc, AuthState>(
      bloc: authBloc,
      builder: (context, state) {
        if (state is! UnauthenticatedState) {
          return Scaffold(
            appBar: buildAAppBar(),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 10,
                ),
                ProfileWidget(
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
                      Row(
                        children: [
                          // Info Button
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: (_selectedIndex == 0)
                                        ? const Color.fromRGBO(64, 194, 210, 1)
                                        : Colors.grey,
                                    width: 3,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedIndex = 0;
                                  });
                                },
                                child: const Text(
                                  'Info',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(10, 44, 64, 1),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Phone Button
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: (_selectedIndex == 1)
                                        ? const Color.fromRGBO(64, 194, 210, 1)
                                        : Colors.grey,
                                    width: 3,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedIndex = 1;
                                  });
                                },
                                child: const Text(
                                  'Settings',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(10, 44, 64, 1),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      if (_selectedIndex == 0) ...[
                        // Info
                        InfoWidget(),
                      ] else if (_selectedIndex == 1) ...[
                        // Settings
                        SettingsWidget(),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
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

  Widget updateInfo(user, context) => Center(
          child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                shape: StadiumBorder(),
                primary: themeBlue),
            child: Text(
              'update',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
// TODO:put the backend logic here

// if backend return success, update the user in the local storage
// dummy update for testing
              String newName = 'user ${DateTime.now().millisecondsSinceEpoch}';
              authDI.sl
                  .get<AuthBloc>()
                  .add(UpdateUserEvent(authBloc.user.copyWith(name: newName)));

              // Navigator.pushNamed(context, '/PersonalInfo');
              // await Navigator.pushNamedAndRemoveUntil(
              //     context, '/UpdateInfo', (route) => false);
            },
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 26.0, vertical: 10.0),
                  shape: StadiumBorder(),
                  primary: theme_red),
              child: Text(
                'logout',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
// TODO:put the backend request here

// if backend return success, remove the user from the local storage
                // await .logout();
                await Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              }),
        ],
      ));
}

//-------Widget for creating textfields with the correct parameters--------
