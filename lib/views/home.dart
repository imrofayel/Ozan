import 'package:flutter/material.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/components/sidebar.dart';
import 'package:ozan/views/notes_view.dart';
import 'package:provider/provider.dart';

import '../components/drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return Consumer<DatabaseProvider>(builder:(context, value, child){

      return const Scaffold(

        endDrawer:  SidebarDrawer(),
        
        body: Row(
        
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            
            Expanded(flex: 1, child: Sidebar()),
              
            Expanded(flex: 23, child: NotesView()),

          ],
        ),
      );
    }
    );
  }
}

Widget _iconButton(IconData icon, void Function()? onPressed){
  return IconButton(onPressed: onPressed, icon: Icon(icon, size: 21));
}