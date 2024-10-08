import 'package:flutter/material.dart';

class Themes {

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

      background: const Color.fromARGB(255, 3, 13, 17),

      secondary: const Color.fromRGBO(6, 32, 42, 1),

      primary: const Color.fromRGBO(4, 19, 25, 1),

      tertiary: const Color.fromRGBO(192, 212, 190, 1),

    ),

    textSelectionTheme: const TextSelectionThemeData(cursorColor: Color.fromARGB(255, 16, 16, 16), selectionColor: Color.fromRGBO(6, 32, 42, 1)),


    appBarTheme:  const AppBarTheme(backgroundColor: Colors.transparent, surfaceTintColor: Colors.transparent),

    tooltipTheme: TooltipThemeData(

      height: 13,

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(

        color: const  Color.fromRGBO(6, 32, 42, 1),
        
        borderRadius: BorderRadius.circular(20)
      ),

      textStyle: const TextStyle(fontSize: 14, color: Color.fromRGBO(192, 212, 190, 1), fontFamily: 'Inter'),
    ),


    expansionTileTheme: ExpansionTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide()),
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide()),
      expandedAlignment: Alignment.centerLeft,
      collapsedIconColor: const Color.fromRGBO(192, 212, 190, 1),
      iconColor: const Color.fromRGBO(192, 212, 190, 1),
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

        backgroundColor: const MaterialStatePropertyAll(Color.fromRGBO(6, 32, 42, 1)),

        shadowColor: const MaterialStatePropertyAll(Colors.transparent),   

        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),

        visualDensity: VisualDensity.comfortable,

      )
    ),
  );
}


