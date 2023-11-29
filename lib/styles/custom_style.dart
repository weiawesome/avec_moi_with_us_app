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
      titleMedium: TextStyle(fontFamily: "McLaren",color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400, height: 0,),
      titleSmall: TextStyle(fontFamily: "McLaren",color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
      labelLarge: TextStyle(fontFamily: "McLaren",fontSize: 30,color: Colors.white,fontWeight: FontWeight.w600,),
      labelMedium: TextStyle(fontFamily: "McLaren",fontSize: 20,color: Colors.grey,fontWeight: FontWeight.w500,),
      labelSmall: TextStyle(fontFamily: "McLaren",fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500,),
      bodyLarge: TextStyle(fontFamily: "McLaren",fontSize: 25,color: Colors.black,fontWeight: FontWeight.w500,),
      bodyMedium: TextStyle(fontFamily: "McLaren",fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500,),
      bodySmall: TextStyle(fontFamily: "McLaren",fontSize: 15,color: Colors.black,fontWeight: FontWeight.w500,),
      displayMedium: TextStyle(fontFamily: "McLaren",fontSize: 35,color: Colors.black,fontWeight: FontWeight.w500,),
      displaySmall: TextStyle(fontFamily: "McLaren",fontSize: 25,color: Colors.black,fontWeight: FontWeight.w500,),
      headlineMedium:TextStyle(fontFamily: "McLaren",fontSize: 25,color: Colors.grey,fontWeight: FontWeight.w400,),




      headlineLarge: TextStyle(color: Colors.black, fontSize:30,fontFamily: 'Play',fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(color: Colors.black, fontSize:13,fontFamily: 'Play',fontWeight: FontWeight.bold),
    ),
  );
}

class DarkStyle {
  static const MaterialColor primarySwatch = Colors.grey;
  static const Color primaryDark = Color(0xFF202124);
  static const Color borderColor = Colors.white30;
  static const BoxDecoration boxDecoration= BoxDecoration(color: Color.fromRGBO(118, 118, 128, 0.24));
  static const Color fileBoxColor= Colors.black;
  static const Color textColor = Color.fromRGBO(60, 60, 67, 0.60);

  static final ThemeData theme = ThemeData(
    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    primarySwatch: primarySwatch,

    primaryColor: primaryDark,
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontFamily: "McLaren",color: Color(0xFFFF0000), fontSize: 60, fontWeight: FontWeight.w400, height: 0,),
      bodyLarge: TextStyle(color: Colors.white, fontSize:36,fontFamily: 'Play',fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.white, fontSize:24,fontFamily: 'Play',fontWeight: FontWeight.bold),
      bodySmall: TextStyle(color: Colors.white, fontSize:17,fontFamily: 'Play',fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: Colors.white, fontSize:24,fontFamily: 'Play',fontWeight: FontWeight.bold),
      displaySmall: TextStyle(color: Colors.white, fontSize:17,fontFamily: 'Play',fontWeight: FontWeight.bold),
      labelLarge: TextStyle(color: Color.fromRGBO(99, 99, 102, 1)),
      labelMedium: TextStyle(color: Colors.white, fontSize:20,fontFamily: 'Play',fontWeight: FontWeight.bold),
      labelSmall: TextStyle(color: Colors.black, fontSize:15,fontFamily: 'Play',fontWeight: FontWeight.bold),
      titleSmall: TextStyle(color: Colors.white, fontSize:15,fontFamily: 'Play',fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Color.fromRGBO(235, 235, 245, 0.6), fontSize:17, fontFamily: 'Play', fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(color: Colors.white70, fontSize:30,fontFamily: 'Play',fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: Colors.white70, fontSize:17,fontFamily: 'Play',fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(color: Colors.white70, fontSize:15,fontFamily: 'Play',fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(51, 71, 250, 0.78)),
        elevation: MaterialStateProperty.all(5),
      ),
    ),
  );
}
