import 'package:flutter/material.dart';

class Themes{

  static ThemeData light = ThemeData(

    colorScheme: ColorScheme.fromSeed(

      seedColor: Colors.red,

      brightness: Brightness.light,
    ),

    fontFamily: "Inter",
    
    useMaterial3: true,

    tooltipTheme: TooltipThemeData(
      height: 13,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20)
      ),

      textStyle: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 3, 7, 3).withOpacity(0.8)),
    )
  );

  /* LIGHT */
  static Color background = const Color.fromARGB(255, 245, 248, 244);

  static Color accent = const Color.fromARGB(255, 250, 250, 250);

  static Color text = const Color.fromARGB(255, 1, 2, 14); 
}