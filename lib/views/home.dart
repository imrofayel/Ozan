import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/theme/theme_provider.dart';
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
      
                  Icon(CupertinoIcons.scribble, size: 36, color: Theme.of(context).colorScheme.tertiary),
              
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

                      padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), child: Text("Library", style: TextStyle(fontSize: 17, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8), fontFamily: 'Inter'))),

                    const Gap(10),

                    FilledButton(onPressed: (){}, style: ButtonStyle(
          
                      side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),

                      padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), child: Text("Journal", style: TextStyle(fontSize: 17, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8), fontFamily: 'Inter'))),
      
                  ],
                ),
              ),
                  
              elevation: 0,
                  
              actions:
                
                [ // SEARCH BUTTON
                  
                  // IconButton(onPressed: () async{
      
                  //   showDialog(context: context, builder: (context){
                  //     return SearchView();
                  //   }, barrierColor: Colors.transparent);
      
                  //   }, icon: Icon(CupertinoIcons.search, size: 22, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6)), style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), overlayColor: const MaterialStatePropertyAll(Colors.transparent))),
      
                  // const Gap(8),
      
                  IconButton(onPressed: (){
      
                    Provider.of<ThemeSwitcher>(context, listen: false).toggleTheme();
      
                    }, icon: Icon(CupertinoIcons.sun_min, size: 22, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6)), style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), overlayColor: const MaterialStatePropertyAll(Colors.transparent))),
      
                  const Gap(8),
                                  
                  IconButton(onPressed: (){
                    showDialog(context: context, builder: (context){
                      return const Configuration();
                    });

                    }, icon: Icon(CupertinoIcons.ellipsis, size: 20, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6)), style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), overlayColor: const MaterialStatePropertyAll(Colors.transparent))),
      
                  const Gap(10),
                
                ],
              ),
      
        body: const Row(
        
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            
            Expanded(flex: 1, child: Sidebar()),
      
            Expanded(flex: 2, child: SizedBox()),
        
            Expanded(flex: 10, child: Markdown()),

            Expanded(flex: 3, child: SizedBox()),

          ],
        ),
      );
    }
    );
  }
}

