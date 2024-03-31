import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/theme/theme_provider.dart';
import 'package:ozan/views/Journal/journal_view.dart';
import 'package:ozan/views/configure.dart';
import 'package:ozan/views/markdown.dart';
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
               
              title: SizedBox(
                
                child: Row(
                  
                  children: [
      
                    IconButton(onPressed: (){}, 
                    
                    icon: Row(

                      children: [

                        Icon(CupertinoIcons.book, size: 22, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8)),

                        const Gap(6),

                        Text('Ozan', textScaler: const TextScaler.linear(1.4), style: TextStyle(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8))),
                      ],
                    ),

                     style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), padding: const MaterialStatePropertyAll(EdgeInsets.fromLTRB(14, 6, 14, 6))),
                    
                    ),
              
                    const Gap(14),
      
                    IconButton(onPressed: (){
                      Markdown.files.newFile(context);
       
                    }, 
                    
                    icon: Icon(CupertinoIcons.add, size: 22, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6)), style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), overlayColor: const MaterialStatePropertyAll(Colors.transparent))),
                    
                    const Gap(13),

                    FilledButton(onPressed: (){

                      Navigator.push(context, MaterialPageRoute(builder:(context) => const NotesView()));

                    }, style: ButtonStyle(
          
                      side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),

                      padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), 
                      
                      
                      child: Row(

                        children: [

                          Icon(CupertinoIcons.collections, size: 20, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8)),

                          const Gap(8),

                          Text('Library', textScaler: const TextScaler.linear(1.3), style: TextStyle(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8))),
                        ],
                    )),

                    const Gap(10),

                    FilledButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context) => const JournalView()));
                    }, style: ButtonStyle(
          
                      side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),

                      padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), 
                      
                      child: Row(

                        children: [

                          Icon(CupertinoIcons.pen, size: 24, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8)),

                          const Gap(3),

                          Text('Journal', textScaler: const TextScaler.linear(1.3), style: TextStyle(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8))),
                        ],
                    )),
      
                  ],
                ),
              ),
                  
              elevation: 0,
                  
              actions:

                [ 
                  
                  FilledButton(onPressed: (){
                      Provider.of<ThemeSwitcher>(context, listen: false).toggleTheme();
                    }, style: ButtonStyle(
          
                      side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),

                      padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), 
                      
                      child: Row(

                        children: [

                          Icon(CupertinoIcons.sun_min, size: 24, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8)),

                          const Gap(6),

                          Text('Theme', textScaler: const TextScaler.linear(1.3), style: TextStyle(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8))),
                        ],
                    )),
      
                  const Gap(8),
                                  
                  IconButton(onPressed: (){
                    showDialog(context: context, builder: (context){

                      return const Configuration();
                      
                    }, barrierColor: Colors.transparent);

                    }, icon: Icon(CupertinoIcons.ellipsis, size: 20, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8)), style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), overlayColor: const MaterialStatePropertyAll(Colors.transparent))),
      
                  const Gap(10),
                
                ],
              ),
      
        body: const Row(
        
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            
            Expanded(flex: 3, child: Sidebar()),
              
            Expanded(flex: 8, child: Markdown()),

            Expanded(flex: 3, child: SizedBox()),

          ],
        ),
      );
    }
    );
  }
}

