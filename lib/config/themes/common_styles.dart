import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const background_gradient = LinearGradient(
  colors: [Color.fromRGBO(0, 34, 51, 1), Color.fromRGBO(0, 113, 130, 1)],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);

// colors
Color themeBlue = Color.fromRGBO(64, 194, 210, 1);
Color themeDarkBlue = Color.fromRGBO(10, 44, 64, 1);
Color themePink = Color.fromRGBO(213, 20, 122, 1);
Color theme_red = Color.fromRGBO(165, 30, 34, 1);
Color theme_orange = Color.fromRGBO(217, 157, 42, 1);
Color primary_color = Color.fromRGBO(252, 252, 252, 1);
Color inputField_color = themeDarkBlue.withOpacity(0.05);
Color theme_grey = Color.fromRGBO(0, 0, 0, 0.5);
// styles

BoxDecoration primary_decoration = BoxDecoration(
    color: primary_color,
    borderRadius: BorderRadius.all(Radius.circular(12)),
    boxShadow: [boxShadow]);

TextStyle textStyle = GoogleFonts.getFont('Almarai',
    fontSize: 27,
    color: themeDarkBlue.withOpacity(0.7),
    decoration: TextDecoration.none,
    fontWeight: FontWeight.normal);

TextStyle greyTextStyle = GoogleFonts.getFont(
  'Almarai',
  fontSize: 27,
  fontWeight: FontWeight.bold,
  color: themeDarkBlue.withOpacity(0.5),
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


ThemeData lightTheme = ThemeData(
  primaryColor: Colors.grey, // Default primary color
  hintColor: Colors.grey, // Default accent color
  scaffoldBackgroundColor: Colors.white, // Another background color option
  highlightColor: Colors.blue, // Highlight color for elements
  // splashColor: Colors.grey, // Splash color for inkwell effects
  selectedRowColor: Colors.blue[50], // Color for selected rows in tables, etc.
  unselectedWidgetColor: Colors.grey, // Color for unselected widgets (checkboxes, radios)
  disabledColor: Colors.grey[400], // Default button color
  secondaryHeaderColor: Colors.blue[200], // Secondary header color
  indicatorColor: Colors.blue, // Tab indicator color

  buttonBarTheme: ButtonBarThemeData(
    buttonTextTheme: ButtonTextTheme.accent,
    layoutBehavior: ButtonBarLayoutBehavior.constrained,
  ),
  iconTheme: IconThemeData(color: Colors.black), // Icon color
  primaryIconTheme: IconThemeData(color: Colors.white), // Accent icon color
  brightness: Brightness.light,
  useMaterial3: false,

  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
    labelLarge: TextStyle(color: Colors.white), // Text color for buttons

  ),

  appBarTheme: AppBarTheme(
    color: Colors.grey, // AppBar background color
    iconTheme: IconThemeData(color: Colors.white), // AppBar icon color
  ),

  dialogBackgroundColor: Colors.white, // Background color for dialogs
  dividerColor: Colors.grey, colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue, // Base color for the color scheme
    primary: Colors.blue, // Primary color used for buttons, etc.
    onPrimary: Colors.white, // Color for text/icons on primary color
    secondary: Colors.blueAccent, // Secondary color
    onSecondary: Colors.white, // Color for text/icons on secondary color
    surface: Colors.white, // Surface color
    onSurface: Colors.black, // Color for text/icons on surface color
    background: Colors.white, // Background color
    onBackground: Colors.black,   // Color for text/icons on background color
    error: Colors.red, // Error color
    onError: Colors.white, // Color for text/icons on error color
    brightness: Brightness.light,

  ).copyWith(background: Colors.white).copyWith(error: Colors.red),

  textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.blue, selectionColor: Colors.blue[300], selectionHandleColor: Colors.blue[600],),

  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.grey), // Hint text color
    suffixStyle: TextStyle(color: Colors.grey), // Suffix icon/text color
    labelStyle: TextStyle(color: Colors.grey), // Label text color
    errorStyle: TextStyle(color: Colors.red), // Error text color
    helperStyle: TextStyle(color: Colors.grey), // Helper text color
    counterStyle: TextStyle(color: Colors.grey), // Counter text color
    filled: true, // Whether the input should be filled
    fillColor: Colors.grey[200], // Fill color for input
    focusColor: Colors.blue, // Focus color for input
    hoverColor: Colors.grey, // Hover color for input
    prefixStyle: TextStyle(color: Colors.grey), // Prefix icon/text color

    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey), // Border color
    ),

  ), // Add other theme properties as needed
);
