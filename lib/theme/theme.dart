import 'package:flutter/material.dart';

class Themes{

  static ThemeData light = ThemeData(

    colorScheme: ColorScheme.fromSeed(

      seedColor: Colors.red,

      brightness: Brightness.light,
    ),

    fontFamily: "Inter",
    
    useMaterial3: true,

  );

  /* LIGHT */
  static Color background = const Color.fromARGB(255, 245, 248, 244);

  static Color accent = const Color.fromARGB(255, 250, 250, 250);

  static Color text = const Color.fromARGB(255, 1, 2, 14); 
}