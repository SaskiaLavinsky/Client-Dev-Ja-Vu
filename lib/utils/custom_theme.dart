import 'package:flutter/material.dart';

class CustomTheme {
  static const Color grey = Color.fromARGB(255, 162, 162, 162);
  static const Color red = Color.fromARGB(255, 148, 45, 38);
  static const cardShadow = [BoxShadow(color: grey, blurRadius: 3, spreadRadius: 3, offset: Offset(0, 2))];
  static const buttonShadow = [BoxShadow(color: grey, blurRadius: 3, spreadRadius: 1, offset: Offset(0, 3))];

  static getCardDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: cardShadow,
      );
  }

  static ThemeData getTheme(){
    Map<String, double> fontSize = {
      "sm": 10,
      "md": 18,
      "lg": 24,
    };

    return ThemeData(
      primaryColor: red,

      //define the default theme font family
      fontFamily: 'Alegreya',
      textTheme: TextTheme(
        headlineLarge: TextStyle(color: Colors.black, fontSize: fontSize['lg']),
        headlineMedium: TextStyle(color: Colors.black, fontSize: fontSize['md']),
        headlineSmall: TextStyle(color: Colors.black, fontSize: fontSize['sm']),
        bodySmall: TextStyle(fontSize: fontSize['sm'], fontWeight: FontWeight.normal),
        titleSmall: TextStyle(fontSize: fontSize['sm'], fontWeight: FontWeight.bold, letterSpacing: 1)
      )
    );
  }
}