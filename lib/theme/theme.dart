import 'package:flutter/material.dart';

class Themes {

  static ThemeData lightTheme = ThemeData(

    brightness: Brightness.light,

    useMaterial3: true,

    fontFamily: "EB Garamond",

    textTheme: const TextTheme(

      bodyMedium: TextStyle(color: Color.fromRGBO(43, 43, 43, 1)),
      
      bodyLarge: TextStyle(color: Color.fromRGBO(43, 43, 43, 1)),

      bodySmall: TextStyle(color: Color.fromRGBO(43, 43, 43, 1)),

    ),

    colorScheme: ColorScheme.fromSeed(

      brightness: Brightness.light,

      seedColor: Colors.black,

      background: const Color.fromRGBO(243, 242, 236, 1),

      primary: const Color.fromRGBO(248, 248, 247, 1),

      tertiary: const Color.fromRGBO(61, 57, 41, 1),

      secondary: const Color.fromRGBO(61, 57, 41, 1)

    ),

    appBarTheme:  const AppBarTheme(backgroundColor: Color.fromRGBO(243, 242, 236, 1)),

    tooltipTheme: TooltipThemeData(

      height: 13,

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(

        color: const Color.fromARGB(255, 236, 236, 236),
        
        borderRadius: BorderRadius.circular(20)
      ),

      textStyle: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 3, 7, 3).withOpacity(0.8), fontFamily: 'Inter'),
    ),

    datePickerTheme: DatePickerThemeData(

      elevation: 0,

      todayBorder: BorderSide.none,

      backgroundColor: const Color.fromARGB(255, 250, 250, 250),

      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30)),

      todayForegroundColor: const MaterialStatePropertyAll(Colors.white),

      todayBackgroundColor: const MaterialStatePropertyAll(Colors.black),

      cancelButtonStyle: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black), foregroundColor: MaterialStatePropertyAll(Colors.white)),

      confirmButtonStyle: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black), foregroundColor: MaterialStatePropertyAll(Colors.white)),

    ), 

    dropdownMenuTheme: DropdownMenuThemeData(

    inputDecorationTheme: InputDecorationTheme(

      border: InputBorder.none,

      enabledBorder: OutlineInputBorder(

      borderRadius: BorderRadius.circular(30),

      borderSide: BorderSide.none
                
      ),

      focusedBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(30),

            borderSide: BorderSide.none
                
          )

      ),

      menuStyle: MenuStyle(
        
        elevation: const MaterialStatePropertyAll(0),

        backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 250, 250, 250)),

        shadowColor: const MaterialStatePropertyAll(Colors.transparent),   

        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),

        visualDensity: VisualDensity.comfortable,

      )
    ),
  );

  static ThemeData darkTheme = ThemeData(

    brightness: Brightness.dark,

    useMaterial3: true,

    fontFamily: "Inter",

    textTheme: const TextTheme(

      bodyMedium: TextStyle(color: Color.fromRGBO(192, 212, 190, 1)),
      
      bodyLarge: TextStyle(color: Color.fromRGBO(192, 212, 190, 1)),

      bodySmall: TextStyle(color: Color.fromRGBO(192, 212, 190, 1)),

    ),

    colorScheme: ColorScheme.fromSeed(

      brightness: Brightness.dark,

      seedColor: Colors.white,

      background: const Color.fromRGBO(9, 11, 16, 1),

      primary: const Color.fromRGBO(15, 17, 26, 1),

      tertiary: const Color.fromRGBO(192, 212, 190, 1),

    ),

    appBarTheme:  const AppBarTheme(backgroundColor: Color.fromRGBO(9, 11, 16, 1)),

    tooltipTheme: TooltipThemeData(

      height: 13,

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(

        color: const Color.fromARGB(255, 8, 8, 8),
        
        borderRadius: BorderRadius.circular(20)
      ),

      textStyle: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8)),
    ),

    datePickerTheme: DatePickerThemeData(

      elevation: 0,

      todayBorder: BorderSide.none,

      backgroundColor: const Color.fromRGBO(40, 47, 40, 1),

      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30)),

      todayForegroundColor: const MaterialStatePropertyAll(Colors.black),

      todayBackgroundColor: const MaterialStatePropertyAll(Colors.white),

      cancelButtonStyle: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white), foregroundColor: MaterialStatePropertyAll(Colors.black)),

      confirmButtonStyle: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white), foregroundColor: MaterialStatePropertyAll(Colors.black)),

    ), 

    dropdownMenuTheme: DropdownMenuThemeData(

    inputDecorationTheme: InputDecorationTheme(

      border: InputBorder.none,

      enabledBorder: OutlineInputBorder(

      borderRadius: BorderRadius.circular(30),

      borderSide: BorderSide.none,
                
      ),

      focusedBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(30),

            borderSide: BorderSide.none
                
          )
      
      ),

      menuStyle: MenuStyle(
        
        elevation: const MaterialStatePropertyAll(0),

        backgroundColor: const MaterialStatePropertyAll(Color.fromRGBO(45, 63, 50, 1)),

        shadowColor: const MaterialStatePropertyAll(Colors.transparent),   

        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),

        visualDensity: VisualDensity.comfortable,

      )
    )
  );
}