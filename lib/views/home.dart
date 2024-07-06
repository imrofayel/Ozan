import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/theme/theme_provider.dart';
import 'package:ozan/components/sidebar.dart';
import 'package:ozan/views/notes_view.dart';
import 'package:provider/provider.dart';

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
      
        appBar: AppBar(
               
              leading: const Padding(
                padding: EdgeInsets.all(10),
                child: Opacity(opacity: 0.9, child: Text('Caira', textScaler: TextScaler.linear(1.6))),
              ),

              leadingWidth: 100,

              centerTitle: true,
                  
              elevation: 0,

              actionsIconTheme: IconThemeData(size: 27, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7)),
                  
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
            
            Expanded(flex: 1, child: Sidebar()),
              
            Expanded(flex: 12, child: NotesView()),

          ],
        ),
      );
    }
    );
  }
}

