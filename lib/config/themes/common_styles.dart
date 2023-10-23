import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const background_gradient = LinearGradient(
  colors: [Color.fromRGBO(0, 34, 51, 1), Color.fromRGBO(0, 113, 130, 1)],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);

// colors
Color theme_green = Color.fromRGBO(64, 194, 210, 1);
Color theme_darkblue = Color.fromRGBO(10, 44, 64, 1);
Color theme_pink = Color.fromRGBO(213, 20, 122, 1);
Color theme_red = Color.fromRGBO(165, 30, 34, 1);
Color theme_orange = Color.fromRGBO(217, 157, 42, 1);
Color primary_color = Color.fromRGBO(252, 252, 252, 1);
Color inputField_color = theme_darkblue.withOpacity(0.05);
Color theme_grey = Color.fromRGBO(0, 0, 0, 0.5);
// styles

BoxDecoration primary_decoration = BoxDecoration(
    color: primary_color,
    borderRadius: BorderRadius.all(Radius.circular(12)),
    boxShadow: [boxShadow]);

TextStyle textStyle = GoogleFonts.getFont('Almarai',
    fontSize: 27,
    color: theme_darkblue.withOpacity(0.7),
    decoration: TextDecoration.none,
    fontWeight: FontWeight.normal);

TextStyle greyTextStyle = GoogleFonts.getFont(
  'Almarai',
  fontSize: 27,
  fontWeight: FontWeight.bold,
  color: theme_darkblue.withOpacity(0.5),
  decoration: TextDecoration.none,
);

// boxshadow
BoxShadow boxShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.1),
  spreadRadius: 0,
  blurRadius: 10,
  offset: const Offset(0, 1),
);

BoxDecoration textField_decoration = BoxDecoration(
  color: Colors.grey.shade200,
  borderRadius: BorderRadius.all(Radius.circular(12)),
);

TextStyle inputText = TextStyle(color: Colors.black54, fontSize: 15);
