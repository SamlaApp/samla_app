import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color themeBlue = Color.fromRGBO(64, 194, 210, 1);
const Color themeDarkBlue = Color.fromRGBO(5, 4, 35, 1);
const Color themePink = Color.fromRGBO(213, 20, 122, 1);
const Color themeRed = Color.fromRGBO(117, 20, 22, 1);
const Color themeOrange = Color.fromRGBO(173, 124, 33, 1);

const Color primaryColor = Color.fromRGBO(10, 10, 10, 0.1);
const Color inputFieldColor =
    Color.fromRGBO(255, 255, 255, 0.1); // Adjusted for dark background
const Color themeGrey =
    Color.fromRGBO(255, 255, 255, 0.5); // Adjusted for dark background
const Color white =
    Color.fromRGBO(255, 255, 255, 1); // Adjusted for dark background

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: primaryColor,

  // Colors Scheme for dark theme
  colorScheme: const ColorScheme.dark(
    primary: white,
    secondary: themePink,
    background: themeDarkBlue,
    surface: themeDarkBlue,
    onPrimary: white,
    onSecondary: white,
    onBackground: white,
    onSurface: white,
  ),
);

BoxDecoration primaryDecoration =  BoxDecoration(
    color: themeDarkBlue.withOpacity(0.3),
    border : Border.fromBorderSide(
        BorderSide(
          color: themeBlue.withOpacity(0.3), // changes position of shadow
          width: 0.5,
        ),
    ),
    borderRadius: const BorderRadius.all(Radius.circular(12)),
);


const backgroundGradient = LinearGradient(
  colors: [Color.fromRGBO(0, 34, 51, 1), Color.fromRGBO(0, 113, 130, 1)],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);