import 'package:flutter/material.dart';

class LightStyle {
  static const MaterialColor primarySwatch = Colors.grey;
  static const Color primaryLight = Color(0xFF443656);
  static const Color borderColor = Colors.black12;

  static const Color fileBoxColor= Color.fromRGBO(236, 236, 236, 0.80);
  static const Color textColor = Color.fromRGBO(235, 235, 245, 0.60);

  static final ThemeData theme = ThemeData(
    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    primarySwatch: primarySwatch,
    primaryColor: primaryLight,
    brightness: Brightness.light,
    cardColor: const Color(0xFF967FB3),

    textTheme: const TextTheme(
      titleLarge: TextStyle(fontFamily: "McLaren",color: Color(0xFF55E9D7), fontSize: 60, fontWeight: FontWeight.w400, height: 0,),
      titleMedium: TextStyle(fontFamily: "McLaren",color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400, height: 0,),
      titleSmall: TextStyle(fontFamily: "McLaren",color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
      labelLarge: TextStyle(fontFamily: "McLaren",fontSize: 30,color: Colors.white,fontWeight: FontWeight.w600,),
      labelMedium: TextStyle(fontFamily: "McLaren",fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500,),
      labelSmall: TextStyle(fontFamily: "McLaren",fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500,),
      bodyLarge: TextStyle(fontFamily: "McLaren",fontSize: 25,color: Colors.black,fontWeight: FontWeight.w500,),
      bodyMedium: TextStyle(fontFamily: "McLaren",fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500,),
      bodySmall: TextStyle(fontFamily: "McLaren",fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500,),
      displayMedium: TextStyle(fontFamily: "McLaren",fontSize: 35,color: Colors.black,fontWeight: FontWeight.w500,),
      displaySmall: TextStyle(fontFamily: "McLaren",fontSize: 25,color: Colors.black,fontWeight: FontWeight.w500,),
      headlineLarge:TextStyle(fontFamily: "McLaren",fontSize: 45,color: Colors.black,fontWeight: FontWeight.w500,),
      headlineMedium:TextStyle(fontFamily: "McLaren",fontSize: 25,color: Colors.grey,fontWeight: FontWeight.w400,),
      headlineSmall:TextStyle(fontFamily: "McLaren",fontSize: 30,color: Colors.white,fontWeight: FontWeight.w400,),

    ),
  );
}

class DarkStyle {
  static const MaterialColor primarySwatch = Colors.grey;
  static const Color primaryLight = Color(0xFF443656);
  static const Color borderColor = Colors.black12;

  static const Color fileBoxColor= Color.fromRGBO(236, 236, 236, 0.80);
  static const Color textColor = Color.fromRGBO(235, 235, 245, 0.60);

  static final ThemeData theme = ThemeData(
    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    primarySwatch: primarySwatch,
    primaryColor: primaryLight,
    brightness: Brightness.light,
    cardColor: const Color(0xFF967FB3),

    textTheme: const TextTheme(
      titleLarge: TextStyle(fontFamily: "McLaren",color: Color(0xFF55E9D7), fontSize: 60, fontWeight: FontWeight.w400, height: 0,),
      titleMedium: TextStyle(fontFamily: "McLaren",color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400, height: 0,),
      titleSmall: TextStyle(fontFamily: "McLaren",color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
      labelLarge: TextStyle(fontFamily: "McLaren",fontSize: 30,color: Colors.white,fontWeight: FontWeight.w600,),
      labelMedium: TextStyle(fontFamily: "McLaren",fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500,),
      labelSmall: TextStyle(fontFamily: "McLaren",fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500,),
      bodyLarge: TextStyle(fontFamily: "McLaren",fontSize: 25,color: Colors.black,fontWeight: FontWeight.w500,),
      bodyMedium: TextStyle(fontFamily: "McLaren",fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500,),
      bodySmall: TextStyle(fontFamily: "McLaren",fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500,),
      displayMedium: TextStyle(fontFamily: "McLaren",fontSize: 35,color: Colors.black,fontWeight: FontWeight.w500,),
      displaySmall: TextStyle(fontFamily: "McLaren",fontSize: 25,color: Colors.black,fontWeight: FontWeight.w500,),
      // headlineLarge:TextStyle(fontFamily: "McLaren",fontSize: 25,color: Colors,fontWeight: FontWeight.w400,),
      headlineMedium:TextStyle(fontFamily: "McLaren",fontSize: 25,color: Colors.grey,fontWeight: FontWeight.w400,),
      headlineSmall:TextStyle(fontFamily: "McLaren",fontSize: 30,color: Colors.white,fontWeight: FontWeight.w400,),

    ),
  );
}
