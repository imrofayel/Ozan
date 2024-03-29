import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/db/notes.dart';
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

    TextEditingController search = TextEditingController();

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
       
                    }, icon: Icon(CupertinoIcons.add, size: 22, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6)), style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), overlayColor: const MaterialStatePropertyAll(Colors.transparent))),
                    
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
                
                [
                  
                  Container(margin: const EdgeInsets.all(8), padding: const EdgeInsets.only(left: 16, right: 6, bottom: 6, top: 0), alignment: Alignment.center, width: 150, decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, border: Border.all(color: Theme.of(context).colorScheme.secondary), borderRadius: BorderRadius.circular(18)), 
                  
                  child: Row(
      
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
                    children: [
      
                    Expanded(child: TextField(
                        
                        decoration: const InputDecoration(border: InputBorder.none),
      
                        style: const TextStyle(fontFamily: 'Inter', fontSize: 18),

                        controller: search,

                        maxLines: 1,
                      )),
      
                      IconButton(onPressed: () async{

                        // ignore: use_build_context_synchronously
                        showSearchView(search.text, await value.dbHelper.getNotesList(), context);
      
                      }, icon: Icon(CupertinoIcons.search, size: 22, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6)), style: const ButtonStyle(overlayColor: MaterialStatePropertyAll(Colors.transparent)))
                    ],
                  ),
                  
                  ),
      
                  const Gap(4),
      
                  IconButton(onPressed: (){
      
                    Provider.of<ThemeSwitcher>(context, listen: false).toggleTheme();
      
                    }, icon: Icon(CupertinoIcons.sun_min, size: 22, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6)), style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), overlayColor: const MaterialStatePropertyAll(Colors.transparent))),
      
                  const Gap(8),
                                  
                  IconButton(onPressed: (){
                    showDialog(context: context, builder: (context){
                      return const Configuration();
                    });

                    }, icon: Icon(CupertinoIcons.person, size: 22, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6)), style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), overlayColor: const MaterialStatePropertyAll(Colors.transparent))),
      
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

showSearchView(value, List<NotesModel> notes, context){

  showDialog(context: context, builder:(context) {
    
    return Column(children: [
      Text(notes.first.title)
    ],);
  });

}

