import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:numberpicker/numberpicker.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/profile/data/profile_requests.dart';
import 'package:samla_app/features/setup/customRectangularButtons.dart';
import 'package:samla_app/features/setup/setHeightPage.dart';
import 'package:samla_app/features/setup/userMeasurment.dart';
// import '../../bloc/auth_bloc.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart'
    as authDI;

// void main() {
//   runApp(const MaterialApp(
//     home: Scaffold(
//       body: Center(
//         child: SelectGender(),
//       ),
//     ),
//   ));
// }

class SelectGenderPage extends StatefulWidget {
  const SelectGenderPage({Key? key}) : super(key: key);
  @override
  _SelectGenderPageState createState() => _SelectGenderPageState();
}

class _SelectGenderPageState extends State<SelectGenderPage> {
  final authBloc = authDI.sl.get<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    final user = authDI.getUser(); //checkTokenValidity

    return Scaffold(
      backgroundColor: theme_darkblue,
      appBar: AppBar(
        toolbarHeight: 200.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>
              Navigator.of(context).pop(), //go previous page (welcome page)
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'images/Logo/White-logo.png',
              height: 60,
              width: 80,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: theme_darkblue,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 0),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Image.asset(
                      'images/SelectGender-pic.png',
                      height: 300,
                      width: 400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
                Center(
                  child: Text(
                    "Select Your Gender",
                    style: TextStyle(
                        color: theme_darkblue,
                        fontWeight: FontWeight.bold,
                        fontSize: 26),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomRectangularButton(
                          iconPath: 'images/Male2.png',
                          buttonText: 'MAN',
                          buttonColor: theme_green),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomRectangularButton2(
                          //or u can call the CustomRectangularButton (However the male text will not be center of FEMALE)
                          iconPath: 'images/female.png',
                          buttonText: 'FEMALE',
                          buttonColor: theme_pink),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Center(
                  child: Container(
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
                        // Navigator.pushReplacementNamed(context,'/setHight'); //should navegate to next page
                        const SetHeightPage(); //should navegate to SetHeightPage
                      },
                      // child: const Text(
                      //   '>',
                      //   style: TextStyle(
                      //     color: Color(0xFF0A2C40),
                      //     fontSize: 35,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 35,
                        color: Color(0xFF0A2C40),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
