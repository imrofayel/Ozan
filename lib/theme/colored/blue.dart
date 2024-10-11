import 'package:flutter/material.dart';

class Blue {

  static const text = Color.fromARGB(255, 0, 0, 0);
  static const secondary = Color.fromRGBO(145, 166, 196, 1);
  static const primary = Color.fromRGBO(225, 237, 255, 1);

  static ThemeData lightTheme(String fontFamily) {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      fontFamily: fontFamily,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: text),
        bodyLarge: TextStyle(color: text),
        bodySmall: TextStyle(color: text),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: text,
        selectionColor: Color.fromRGBO(185, 214, 255, 1),
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: Colors.blue,
        background: primary,
        secondary: secondary,
        primary: const Color.fromRGBO(234, 243, 255, 1),
        tertiary: text,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      drawerTheme: const DrawerThemeData(
        scrimColor: Colors.transparent,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        expandedAlignment: Alignment.centerLeft,
        collapsedIconColor: secondary,
        iconColor: secondary,
        backgroundColor: primary,
      ),
      tooltipTheme: TooltipThemeData(
        height: 13,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: secondary.withOpacity(0.2))
        ),
        textStyle: TextStyle(
          fontSize: 14,
          color: text,
          fontFamily: fontFamily,
        ),
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
            borderSide: BorderSide.none,
          ),
        ),
        menuStyle: MenuStyle(
          elevation: const MaterialStatePropertyAll(0),
          backgroundColor: const MaterialStatePropertyAll(primary),
          shadowColor: const MaterialStatePropertyAll(Colors.transparent),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
          visualDensity: VisualDensity.comfortable,
        ),
      ),
    );
  }
}

