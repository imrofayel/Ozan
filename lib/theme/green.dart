import 'package:flutter/material.dart';

class Green {

  static const text = Color.fromRGBO(6, 30, 15, 1);

  static const secondary = Color.fromARGB(255, 143, 177, 156);

  static const primary = Color.fromRGBO(237, 255, 243, 1);


  static ThemeData lightTheme = ThemeData(

    brightness: Brightness.light,

    useMaterial3: true,

    fontFamily: 'Inter',

    textTheme: const TextTheme(

      bodyMedium: TextStyle(color: text),
      
      bodyLarge: TextStyle(color:  text),

      bodySmall: TextStyle(color:  text)

    ),

    textSelectionTheme: const TextSelectionThemeData(cursorColor: text, selectionColor:  Color.fromRGBO(220, 238, 226, 1)),

    colorScheme: ColorScheme.fromSeed(

      brightness: Brightness.light,

      seedColor: Colors.green,

      background: primary,

      secondary: secondary,

      primary: const Color.fromRGBO(247, 253, 249, 1),

      tertiary: text,

    ),

    appBarTheme:  const AppBarTheme(backgroundColor: Colors.transparent, surfaceTintColor: Colors.transparent),

    drawerTheme: const DrawerThemeData(scrimColor: Colors.transparent),

    expansionTileTheme: ExpansionTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide()),
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide()),
      expandedAlignment: Alignment.centerLeft,
      collapsedIconColor: secondary,
      iconColor: secondary,
    ),

    tooltipTheme: TooltipThemeData(

      height: 13,

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(

        color: primary,
        
        borderRadius: BorderRadius.circular(20)
      ),

      textStyle: TextStyle(fontSize: 14, color: Colors.blueGrey.shade900.withOpacity(0.95), fontFamily: 'Inter'),
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

        backgroundColor: const MaterialStatePropertyAll(primary),

        shadowColor: const MaterialStatePropertyAll(Colors.transparent),   

        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),

        visualDensity: VisualDensity.comfortable,

      )
    ),
  );
}


