import 'package:flutter/material.dart';

class DarkTheme {
  static ThemeData themeData({required BuildContext context,required bool isDark}){

    return ThemeData(
      scaffoldBackgroundColor: isDark?Colors.black:Colors.grey.shade200,
      primarySwatch: Colors.blue,
      primaryColor: isDark?Colors.black:Colors.grey[300],
      accentColor: Colors.blueAccent,
      backgroundColor: isDark?Colors.black:Colors.grey[300],
      indicatorColor: isDark?Color(0xff0E1D36):Color(0xffCBDCF8),
      buttonColor:isDark?Color(0xff3B3B3B) : Color(0xffF1F5FB),
      hintColor: isDark? Colors.grey.shade300 : Colors.grey.shade800,
      highlightColor: isDark ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDark ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDark ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      textSelectionColor: isDark ? Colors.white : Colors.black,
      cardColor: isDark ? Color(0xFF151515) : Colors.white,
      canvasColor: isDark ? Colors.black : Colors.grey[50],
      brightness: isDark ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(colorScheme: isDark ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),





    );
  }
}

// import 'dart:ui';
//
// import 'package:flutter/material.dart';
//
// class Styles {
//   static ThemeData themeData(bool isDarkTheme, BuildContext context) {
//     return ThemeData(
//       scaffoldBackgroundColor: isDarkTheme ? Colors.black :Colors.grey.shade300,
//       primarySwatch: Colors.purple,
//       primaryColor: isDarkTheme ? Colors.black : Colors.grey.shade300,
//       accentColor: Colors.deepPurple,
//       backgroundColor: isDarkTheme ? Colors.grey.shade700 : Colors.white,
//       indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
//       buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
//       hintColor: isDarkTheme ? Colors.grey.shade300 : Colors.grey.shade800,
//       highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
//       hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
//       focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
//       disabledColor: Colors.grey,
//       textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
//       cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
//       canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
//       brightness: isDarkTheme ? Brightness.dark : Brightness.light,
//       buttonTheme: Theme.of(context).buttonTheme.copyWith(
//           colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
//       appBarTheme: AppBarTheme(
//         elevation: 0.0,
//       ),
//     );
//   }
// }

