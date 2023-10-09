// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/core/auth/User.dart';
import 'package:samla_app/features/profile/presentation/widgets/AppBar_Widget01.dart';
import 'package:samla_app/features/profile/presentation/widgets/appBar_widget.dart';
import 'package:samla_app/features/profile/presentation/widgets/profile_widget.dart';
import 'package:samla_app/features/profile/presentation/widgets/Achievments.dart';

import '../widgets/numbers.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final String imagePath = 'images/download.jpeg';

  @override
  Widget build(BuildContext context) {
    final user = LocalAuth.user;
    print('rebuild profile page');
    return Scaffold(
        appBar: buildAAppBar(),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 40,
            ),
            ProfileWidget(
              imgPath: imagePath,
              onClicked: () async {},
            ),
            SizedBox(
              height: 20,
            ),
            buildName_email(user),
            SizedBox(
              height: 25,
            ),
            NumbersWidget(),
            SizedBox(
              height: 5,
            ),
            Achievments(
              challengeName: '',
            ),
            Center(child: updateInfo(user, context)),
          ],
        ));
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
                primary: theme_green),
            child: Text(
              'update',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
// TODO:put the backend logic here

// if backend return success, update the user in the local storage
// dummy update for testing
              String newName = 'user ${DateTime.now().millisecondsSinceEpoch}';
              await LocalAuth.updateUser(name: newName);
              Navigator.pushNamed(context, '/PersonalInfo');
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
                await LocalAuth.resetCacheUser();
                await Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              }),
        ],
      ));
}
