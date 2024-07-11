import 'package:flutter/material.dart';

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

      child: const Row(
        children: [

          
        ],
      ),
      
    );
  }
}

