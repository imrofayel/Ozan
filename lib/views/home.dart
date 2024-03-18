import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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

    return Scaffold(

      appBar: AppBar(
             
            title: SizedBox(
              
              child: Row(
                
                children: [

                IconButton(onPressed: (){
                  }, icon: Icon(CupertinoIcons.scribble, size: 36, color: Theme.of(context).colorScheme.tertiary)),
            
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
                  
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary.withOpacity(0.8)), padding: const MaterialStatePropertyAll(EdgeInsets.all(20)),
                  
                  side: MaterialStatePropertyAll(BorderSide(width: 1, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6))),

                  overlayColor: const MaterialStatePropertyAll(Colors.transparent),

                  shadowColor: const MaterialStatePropertyAll(Colors.transparent)
                  
                  ),
                  
                  
                  child: Text('Saved', style: TextStyle(fontSize: 20, fontFamily: 'Inter', color: Theme.of(context).colorScheme.tertiary, fontWeight: FontWeight.w400))),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}