import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/providers/filter_db.dart';
import 'package:ozan/providers/fonts.dart';
import 'package:ozan/providers/navigation_provider.dart';
import 'package:ozan/theme/colored/green.dart';
import 'package:ozan/theme/theme_provider.dart';
import 'package:ozan/home.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'providers/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Must add this line.
  await windowManager.ensureInitialized();


  WindowOptions windowOptions = const WindowOptions(
    center: true,
    titleBarStyle: TitleBarStyle.normal,
    title: 'Ozan',
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    fullScreen: false,
    minimumSize: Size(400, 400)
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setMaximizable(true);  // Prevent manual maximizing
    await windowManager.setMinimizable(true);
    await windowManager.maximize();  // Prevent minimizing
    await windowManager.setResizable(true);    // Prevent resizing
  });

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => DatabaseProvider()),
      ChangeNotifierProvider(create: (_) => FilterState()),
      ChangeNotifierProvider(create: (_) => Navigation()),
      ChangeNotifierProvider(create: (_) => AppState()),
      ChangeNotifierProvider(create: (_) => FontChanger()),

            ChangeNotifierProvider(create: (context) => ThemeAndFontProvider()),
    ],
    child: ImageFiltered(imageFilter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3), child: const Ozan()),
  ));
}

class Ozan extends StatefulWidget {
  const Ozan({super.key});

  @override
  State<Ozan> createState() => _OzanState();
}

class _OzanState extends State<Ozan> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeAndFontProvider>(builder: (context, value, child) =>
      MaterialApp(
        title: "Ozan",
        debugShowCheckedModeBanner: false,
        theme: value.themeData,
        // theme: Brown.lightTheme,
        home: const Scaffold(
          body: Home(),
        ),
      ),
    );
  }
}