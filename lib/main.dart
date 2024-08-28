import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ozan/components/filter_db.dart';
import 'package:ozan/components/preferences.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/navigation_provider.dart';
import 'package:ozan/theme/green.dart';
import 'package:ozan/theme/theme.dart';
import 'package:ozan/theme/theme_provider.dart';
import 'package:ozan/views/home.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(650, 650),
    center: true,
    titleBarStyle: TitleBarStyle.normal,
    title: 'Ozan',
    minimumSize: Size(650, 650),
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => DatabaseProvider()),
      ChangeNotifierProvider(create: (_) => FilterState()),
      ChangeNotifierProvider(create: (_) => Navigation()),
      ChangeNotifierProvider(create: (context) => AppState()),
         ChangeNotifierProxyProvider<AppState, ThemeSwitcher>(
        create: (context) => ThemeSwitcher(context),
        update: (context, appState, themeSwitcher) {
          themeSwitcher ??= ThemeSwitcher(context);
          if (appState.isDarkMode) {
            themeSwitcher.themeData = Themes.darkTheme;
          } else {
            themeSwitcher.themeData = Themes.lightTheme;
          }
          return themeSwitcher;
        },
      ),
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
    return MaterialApp(
      title: "Ozan",
      debugShowCheckedModeBanner: false,
      // theme: Provider.of<ThemeSwitcher>(context).themeData,
      theme: Green.lightTheme,
      home: const Scaffold(
        body: Home(),
      ),
    );
  }
}