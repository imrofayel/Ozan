import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              
                    const Gap(10),
      
                    IconButton(onPressed: (){
                      Markdown.files.newFile(context);
       
                    }, icon: Icon(CupertinoIcons.add, color: Theme.of(context).colorScheme.tertiary)),
      
                  ],
                ),
              ),
                  
              elevation: 0,
                  
              actions:
                
                [
                  
                  Container(margin: const EdgeInsets.all(4), padding: const EdgeInsets.only(left: 16, right: 6), alignment: Alignment.center, width: 200,decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, border: Border.all(color: Theme.of(context).colorScheme.secondary), borderRadius: BorderRadius.circular(18)), 
                  
                  child: Row(
      
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
                    children: [
      
                    Expanded(child: TextField(
                        
                        decoration: const InputDecoration(border: InputBorder.none),
      
                        style: const TextStyle(fontFamily: 'Inter', fontSize: 18),

                        controller: search,
                      )),
      
                      IconButton(onPressed: () async{

                        // ignore: use_build_context_synchronously
                        showSearchView(search.text, await value.dbHelper.getNotesList(), context);
      
                      }, icon: const Icon(CupertinoIcons.search))
                    ],
                  ),
                  
                  ),
      
                  const Gap(12),
      
                  IconButton(onPressed: (){
      
                    Provider.of<ThemeSwitcher>(context, listen: false).toggleTheme();
      
                  }, icon: Icon(CupertinoIcons.sun_min, size: 26, color: Theme.of(context).colorScheme.tertiary)),
      
                  const Gap(3),
                                  
                  IconButton(onPressed: (){
                    showDialog(context: context, builder: (context){
                      return const Configuration();
                    });
                  }, icon: Icon(CupertinoIcons.person, size: 26, color: Theme.of(context).colorScheme.tertiary,)),
      
                  const Gap(10),
                
                ],
              ),
      
        body: Row(
        
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            
            const Expanded(flex: 1, child: Sidebar()),
      
            const Expanded(flex: 2, child: SizedBox()),
        
            const Expanded(flex: 10, child: Markdown()),
      
            Expanded(flex: 3, child: SizedBox(
      
              child: Column(
      
                crossAxisAlignment: CrossAxisAlignment.center,
      
                mainAxisAlignment: MainAxisAlignment.end,
      
                children: [
                  
                  Padding(
                  
                    padding: const EdgeInsets.only(bottom: 30),
                  
                    child: FilledButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context) => const NotesView()));
                    }, 
                    
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.tertiary), padding: const MaterialStatePropertyAll(EdgeInsets.all(20)), shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
      
                    overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      
                    shadowColor: const MaterialStatePropertyAll(Colors.transparent)
                    
                    ),
                    
                    child: Text('Saved', style: TextStyle(fontSize: 20, fontFamily: 'Inter', color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w400))),
                  ),
                ],
              ),
            )),
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