import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Raya extends StatefulWidget {
  const Raya({super.key});

  @override
  State<Raya> createState() => _RayaState();
}

class _RayaState extends State<Raya> {

  @override
  Widget build(BuildContext context) {

    return show(

        height: 200, width: 200,

        color: Colors.white,
    );
  }
}