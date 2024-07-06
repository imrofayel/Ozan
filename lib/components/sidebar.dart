import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ozan/components/ai.dart';
import 'package:ozan/views/Journal/journal_view.dart';
import 'package:ozan/views/notes_view.dart';
import 'package:page_transition/page_transition.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      scrollDirection: Axis.vertical,
      
      child: SizedBox(

        height: MediaQuery.of(context).size.height - 60,
        
        child: Padding(

          padding: const EdgeInsets.all(16),

          child: Column(
          
            crossAxisAlignment: CrossAxisAlignment.start,
          
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
            children: [

              Column(
                children: [

                  InkWell(child: Icon(Iconsax.home_2_copy, size: 23, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8))),
                  
                  const Gap(33),

                  InkWell(child: Icon(Iconsax.hierarchy_copy, size: 21, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8))),

                  const Gap(35),

                  InkWell(child: Icon(Iconsax.note_2_copy, size: 23, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8)),
                  
                  onTap: () => Navigator.push(context, PageTransition(type: PageTransitionType.fade, duration: const Duration(milliseconds: 300), child: const NotesView()))),

                  const Gap(33),

                  InkWell(child: Icon(Iconsax.heart_copy, size: 23, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8)),
                  
                  onTap: () => Navigator.push(context, PageTransition(type: PageTransitionType.fade, duration: const Duration(milliseconds: 300), child: const JournalView()))),

                ],
              ),
                    
              Row(children: [
                
                InkWell(onTap: () => {

                  show

                },
                
                
                
                child: Icon(Iconsax.flash_copy, size: 24, color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).colorScheme.tertiary.withOpacity(0.8) : Colors.blue.shade900,),
                ),

              ])
                          
            ],
          ),
        )
      ),
    );
  } 
}

