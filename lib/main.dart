import 'package:flutter/material.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/theme/theme_provider.dart';
import 'package:ozan/views/home.dart';
import 'package:provider/provider.dart';

void main() async {
  
  runApp(MultiProvider(providers: [

    ChangeNotifierProvider(create:(context) => DatabaseProvider()),

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

        title: "Rofayel Notebook",

        debugShowCheckedModeBanner: false,

        theme: Provider.of<ThemeSwitcher>(context).themeData,
        
        home: const Scaffold(

          body: Home(),
        ),
      );
  }
}
