import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color themeBlue = Color.fromRGBO(64, 194, 210, 1);
const Color themeDarkBlue = Color.fromRGBO(5, 4, 35, 1);
const Color themePink = Color.fromRGBO(213, 20, 122, 1);
const Color themeRed = Color.fromRGBO(117, 20, 22, 1);
// F7923F
const Color themeOrange = Color.fromRGBO(247, 146, 63, 1);

Color primaryColor = themeDarkBlue.withOpacity(0.8);
const Color inputFieldColor = Colors.white;
Color themeGrey = themeDarkBlue.withOpacity(0.5);
const Color white =
    Color.fromRGBO(255, 255, 255, 1); // Adjusted for dark background

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: white,
  primaryColor: primaryColor,

  // Colors Scheme for dark theme
  colorScheme: ColorScheme.dark(
    primary: themeDarkBlue,
    secondary: themePink,
    background: white,
    surface: white,
    onPrimary: themeDarkBlue,
    onSecondary: white,
    onBackground: themeDarkBlue.withOpacity(0.5),
    onSurface: themeDarkBlue.withOpacity(0.5),
  ),

  // main font is cairo
  textTheme: GoogleFonts.cairoTextTheme(),
  primaryTextTheme: GoogleFonts.cairoTextTheme(),

  // card theme
  cardTheme: CardTheme(
    color: white,
    shadowColor: themeDarkBlue.withOpacity(0.1),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),

);

BoxDecoration primaryDecoration =  BoxDecoration(
    color: white,
    border : Border.fromBorderSide(
        BorderSide(
          color: themeDarkBlue.withOpacity(0.2),
          width: 0.5,
        ),
    ),
    borderRadius: const BorderRadius.all(Radius.circular(12)),
    boxShadow: [boxShadow]
);


BoxShadow boxShadow = BoxShadow(
  color: themeDarkBlue.withOpacity(0.05),
  spreadRadius: 1,
  blurRadius: 20,
  offset: const Offset(0, 1),
  blurStyle: BlurStyle.outer,
);