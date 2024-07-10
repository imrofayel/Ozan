import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/theme/theme_provider.dart';
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

              actionsIconTheme: IconThemeData(size: 26, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7)),
                  
              actions:

                [
                                  
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: InkWell(
                      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                      child: Tooltip(
                        message: Theme.of(context).brightness == Brightness.dark ? 'Light Theme' : 'Dark Theme',
                        child: Icon(
                          Theme.of(context).brightness == Brightness.dark ? Iconsax.toggle_on_circle_copy : Iconsax.toggle_off_circle_copy,
                          ),
                      ),

                        onTap: () => Provider.of<ThemeSwitcher>(context, listen: false).toggleTheme()
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
