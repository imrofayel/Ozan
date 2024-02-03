import 'package:flutter/material.dart';
import 'package:ozan/views/configure.dart';

class Themes{

  static ThemeData light = ThemeData(

    colorScheme: ColorScheme.fromSeed(

      seedColor: getTheme(),

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
    ),

    datePickerTheme: DatePickerThemeData(

      elevation: 0,

      todayBorder: BorderSide.none,

      backgroundColor: Colors.white.withOpacity(0.9),

      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30)),

    ), 

    dropdownMenuTheme: DropdownMenuThemeData(

    inputDecorationTheme: InputDecorationTheme(

      fillColor: Themes.background.withOpacity(0.77),

      filled: true,

      border: InputBorder.none,

      enabledBorder: OutlineInputBorder(

      borderRadius: BorderRadius.circular(30),

      borderSide: BorderSide.none
                
      ),

      activeIndicatorBorder: BorderSide(color: Themes.accent),

      focusedBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(30),

            borderSide: BorderSide.none
                
          )

      ),

      menuStyle: MenuStyle(
        
        elevation: const MaterialStatePropertyAll(0),

        backgroundColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.8)),

        shadowColor: const MaterialStatePropertyAll(Colors.transparent),   

        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),

        surfaceTintColor: MaterialStatePropertyAll(Themes.accent),

        visualDensity: VisualDensity.comfortable,

      )
    )
  );

  /* LIGHT */
  static Color background = const Color.fromARGB(255, 245, 248, 244);

  static Color accent = const Color.fromARGB(255, 250, 250, 250);

  static Color text = const Color.fromARGB(255, 1, 2, 14); 
}