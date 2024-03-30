import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Configuration extends StatefulWidget {
  const Configuration({super.key});

  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {

  @override
  Widget build(BuildContext context) {

    return SimpleDialog(

      shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).colorScheme.secondary), borderRadius: BorderRadius.circular(16)),

      surfaceTintColor: Colors.transparent,

      elevation: 0,

      shadowColor: Colors.transparent,

      children: const[

        Info(),

      ]
    );
  }
}

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {

  @override
  Widget build(BuildContext context) {

    return Container(
      
      padding: const EdgeInsets.all(14),

      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,

        crossAxisAlignment: CrossAxisAlignment.start,
      
        children: [
      
          // Name & Icon
          Row(

            children: [

              FilledButton(
              
                onPressed: (){},
              
                style: ButtonStyle(
              
                  side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),
              
                  padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), 
              
                child: Padding(

                  padding: const EdgeInsets.all(6),

                  child: Row(
                    
                    children: [
                  
                      Icon(CupertinoIcons.pencil_outline, size: 24, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9),),
                              
                      const Gap(8),
                              
                      Text("Rofayel Notebook v4.0", style: TextStyle(fontSize: 19, fontFamily: 'Inter', color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9))),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const Gap(10),

          SizedBox(

            width: 400,

            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: RichText(
                    
                      text: TextSpan(
                    
                        children: [
                    
                          TextSpan(text: 'by Naveed azhar', style: TextStyle(fontSize: 32, fontStyle: FontStyle.italic, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9), fontFamily: 'EB Garamond', fontWeight: FontWeight.w500)),
                        ]
                      )
                    ),
                  ),

                  FilledButton(
                  
                    onPressed: (){
                    },
                  
                    style: ButtonStyle(
                  
                      side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),
                  
                      padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), 
                  
                    child: Padding(

                      padding: const EdgeInsets.all(6),

                      child: Row(
                        
                        children: [
                      
                          Icon(CupertinoIcons.pencil_outline, size: 24, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9),),
                                  
                          const Gap(8),
                                  
                          Text("Rofayel Notebook v4.0", style: TextStyle(fontSize: 19, fontFamily: 'Inter', color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9))),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          ),
        ],
      ),
    );
  }
}