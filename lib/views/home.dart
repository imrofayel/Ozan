import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ozan/theme/theme_provider.dart';
import 'package:ozan/views/configure.dart';
import 'package:ozan/views/markdown.dart';
import 'package:ozan/components/sidebar.dart';
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
              
                  Icon(CupertinoIcons.scribble, size: 36, color: Theme.of(context).colorScheme.tertiary),
            
                  const Gap(10),

                  IconButton(onPressed: () => Markdown.files.newFile(context), icon: Icon(CupertinoIcons.add, color: Theme.of(context).colorScheme.tertiary),)
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

      body: const Row(
      
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          
          Expanded(flex: 1, child: Sidebar()),

          Expanded(flex: 2, child: SizedBox()),
      
          Expanded(flex: 15, child: Markdown()),

          Expanded(flex: 2, child: SizedBox()),
        ],
      ),
    );
  }
}