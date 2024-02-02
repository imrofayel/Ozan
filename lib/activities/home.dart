import 'package:flutter/material.dart';
import 'package:ozan/components/markdown.dart';
import 'package:ozan/components/sidebar.dart';
import 'package:ozan/theme/theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Themes.background,

      body: const Row(
        children: [
          
          Expanded(flex: 1, child: Sidebar()),

          Expanded(flex: 11, child: Markdown()),
        ],
      ),
    );
  }
}