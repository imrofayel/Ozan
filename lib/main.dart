import 'package:flutter/material.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/db/journal_db/journal_db_provider.dart';
import 'package:ozan/theme/theme_provider.dart';
import 'package:ozan/views/home.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 660),
    center: true,
    titleBarStyle: TitleBarStyle.normal,
    title: 'Ozan',
    minimumSize: Size(700, 600),
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  
  runApp(MultiProvider(providers: [

    ChangeNotifierProvider(create:(context) => DatabaseProvider()),

    ChangeNotifierProvider(create:(context) => JournalDatabaseProvider()),

    ChangeNotifierProvider(create:(context) => ThemeSwitcher()),

  ],



  child: const Ozan()));
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

        theme: Provider.of<ThemeSwitcher>(context).themeData,
        
        home: const Scaffold(

          body: Home(),
        ),
      );
  }
}
