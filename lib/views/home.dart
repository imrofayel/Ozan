import 'package:flutter/cupertino.dart';
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

      return Scaffold(

        endDrawer: const SidebarDrawer(),
      
        appBar: AppBar(
               
              title: Builder(

                builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(CupertinoIcons.ellipsis, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7), size: 22),
                    onPressed: () { Scaffold.of(context).openEndDrawer(); },
                    tooltip: 'Sidebar', hoverColor: Theme.of(context).colorScheme.primary, style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)),
                  );
                },
              ),
                  
              elevation: 0,

              actionsIconTheme: IconThemeData(size: 24, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8)),
                  
              actions:

                [
                                  
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: InkWell(
                      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                      child: const Tooltip(
                        message: 'Sync Coming Soon',
                        child: Icon(
                          CupertinoIcons.cloud
                          ),
                      ),

                        onTap: (){}
                    )
                    ),
                
                ],
              ),
        
        body: const Row(
        
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            
            Expanded(flex: 2, child: Sidebar()),
              
            Expanded(flex: 18, child: NotesView()),

          ],
        ),
      );
    }
    );
  }
}
