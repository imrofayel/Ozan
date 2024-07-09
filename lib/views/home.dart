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

        drawer: const SidebarDrawer(),
      
        appBar: AppBar(
               
              leading:Builder(

                builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(Iconsax.sidebar_right_copy, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8), size: 23),
                    onPressed: () { Scaffold.of(context).openDrawer(); },
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip, hoverColor: Theme.of(context).colorScheme.primary,
                  );
                },
              ),

              centerTitle: true,
                  
              elevation: 0,

              actionsIconTheme: IconThemeData(size: 26, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7)),
                  
              actions:

                [
                                  
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: InkWell(
                      child: Icon(
                        Theme.of(context).brightness == Brightness.dark ? Iconsax.toggle_on_circle_copy : Iconsax.toggle_off_circle_copy,
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
