import 'package:flutter/material.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/providers/filter_db.dart';
import 'package:ozan/providers/navigation_provider.dart';
import 'package:ozan/theme/colored/blue.dart';
import 'package:ozan/theme/colored/brown.dart';
import 'package:ozan/theme/colored/green.dart';
import 'package:ozan/theme/theme_provider.dart';
import 'package:ozan/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

import 'providers/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    center: true,
    titleBarStyle: TitleBarStyle.normal,
    title: 'Ozan',
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    fullScreen: false,
    minimumSize: Size(400, 400),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setMaximizable(true);
    await windowManager.setMinimizable(true);
    await windowManager.maximize();
    await windowManager.setResizable(true);
  });

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String savedFont = prefs.getString('fontFamily') ?? 'Inter';
  String savedTheme = prefs.getString('theme') ?? 'brown';
  ThemeData initialTheme;

  if (savedTheme == 'blue') {
    initialTheme = Blue.lightTheme(savedFont);
  } else if (savedTheme == 'green') {
    initialTheme = Green.lightTheme(savedFont);
  } else {
    initialTheme = Brown.lightTheme(savedFont);
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => DatabaseProvider()),
      ChangeNotifierProvider(create: (_) => FilterState()),
      ChangeNotifierProvider(create: (_) => Navigation()),
      ChangeNotifierProvider(create: (_) => AppState()),
      ChangeNotifierProvider(create: (context) => ThemeAndFontProvider(initialTheme, savedFont)),
    ],
    child: const Ozan(),
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
    return Consumer<ThemeAndFontProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: "Ozan",
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData,
          home: Scaffold(
            body: Consumer<Navigation>(
              builder: (context, navigation, child) {
                return const Home();  // Access Navigation properly here
              },
            ),
          ),
        );
      },
    );
  }
}
