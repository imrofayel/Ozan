import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ozan/components/markdown.dart';
import 'package:ozan/components/components.dart';
import 'package:ozan/theme/theme.dart';

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
      
      child: Container(
      
        alignment: Alignment.center,
      
        child: Column(
      
          mainAxisAlignment: MainAxisAlignment.center,
      
          children: [
            
            Container(
              
              width: 60, height: 60, 
            
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),

              child: button(() {}, Iconsax.home, context, tooltip: "Home"),

            ),
            
            const Gap(25),
      
            Container(
      
              width: 60, height: 200, 
            
              decoration: BoxDecoration(
                color: Themes.accent,
                borderRadius: BorderRadius.circular(30),
              ),

              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                button(() => Markdown.files.newFile(context), Iconsax.add_circle, context, tooltip: "New File"),

                button(() => Markdown.files.loadFile(context), Iconsax.arrow_circle_up, context, tooltip: "Import"),

                button(null, Iconsax.info_circle, context, tooltip: "About"),

                ],
              )
            ),
      
            const Gap(25),
      
            Container(
              
              width: 60, height: 60, 
            
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),

              child: button(() => Markdown.files.saveContent(context), Iconsax.import_1, context, tooltip: "Export"),
            ),
          ],
        )
      ),
    );
  } 
}

