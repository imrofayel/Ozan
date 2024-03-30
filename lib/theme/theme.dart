import 'package:flutter/material.dart';

class Themes {

  static ThemeData lightTheme = ThemeData(

    brightness: Brightness.light,

    useMaterial3: true,

    fontFamily: 'Inter',

    textTheme: const TextTheme(

      bodyMedium: TextStyle(color: Color.fromARGB(255, 16, 16, 16)),
      
      bodyLarge: TextStyle(color:  Color.fromARGB(255, 16, 16, 16)),

      bodySmall: TextStyle(color:  Color.fromARGB(255, 16, 16, 16))

    ),

    textSelectionTheme: const TextSelectionThemeData(cursorColor: Color.fromARGB(255, 16, 16, 16), selectionColor: Color.fromRGBO(233, 231, 227, 1)),

    colorScheme: ColorScheme.fromSeed(

      brightness: Brightness.light,

      seedColor: Colors.white,

      background: const Color.fromRGBO(255, 255, 255, 1),

      secondary: const Color.fromRGBO(243, 243, 243, 1),

      primary: const Color.fromRGBO(249, 249, 252, 1),

      tertiary: const Color.fromARGB(255, 16, 16, 16),

    ),

    appBarTheme:  const AppBarTheme(backgroundColor: Colors.transparent, surfaceTintColor: Colors.transparent),

    tooltipTheme: TooltipThemeData(

      height: 13,

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(

        color: const Color.fromRGBO(249, 249, 252, 1),
        
        borderRadius: BorderRadius.circular(20)
      ),

      textStyle: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 3, 7, 3).withOpacity(0.8), fontFamily: 'Inter'),
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

    useMaterial3: true,

    fontFamily: 'Inter',

    textTheme: const TextTheme(

      bodyMedium: TextStyle(color: Color.fromRGBO(192, 212, 190, 1)),
      
      bodyLarge: TextStyle(color: Color.fromRGBO(192, 212, 190, 1)),

      bodySmall: TextStyle(color: Color.fromRGBO(192, 212, 190, 1)),

    ),

    colorScheme: ColorScheme.fromSeed(

      brightness: Brightness.dark,

      seedColor: Colors.green,

      background: const Color.fromRGBO(40, 47, 40, 1),

      secondary: const Color.fromRGBO(45, 63, 50, 1),

      primary: const Color.fromRGBO(45, 63, 50, 1),

      tertiary: const Color.fromRGBO(192, 212, 190, 1),

    ),

    textSelectionTheme: const TextSelectionThemeData(cursorColor: Color.fromARGB(255, 16, 16, 16), selectionColor: Color.fromRGBO(46, 66, 52, 1)),


    appBarTheme:  const AppBarTheme(backgroundColor: Colors.transparent, surfaceTintColor: Colors.transparent),

    tooltipTheme: TooltipThemeData(

      height: 13,

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(

        color: const  Color.fromRGBO(45, 63, 50, 1),
        
        borderRadius: BorderRadius.circular(20)
      ),

      textStyle: const TextStyle(fontSize: 18, color: Color.fromRGBO(192, 212, 190, 1), fontFamily: 'Inter'),
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

        backgroundColor: const MaterialStatePropertyAll(Color.fromRGBO(45, 63, 50, 1)),

        shadowColor: const MaterialStatePropertyAll(Colors.transparent),   

        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),

        visualDensity: VisualDensity.comfortable,

      )
    ),
  );
}


