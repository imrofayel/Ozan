import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Drawer(

      elevation: 0,      

      surfaceTintColor: Colors.transparent,

      shadowColor: Colors.transparent,

      width: 330,

      backgroundColor: Theme.of(context).colorScheme.primary,

      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      
    );
  }
}

