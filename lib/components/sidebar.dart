import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ozan/components/markdown.dart';
import 'package:ozan/components/components.dart';
import 'package:ozan/theme/theme.dart';
import 'package:ozan/views/configure.dart';

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
        
        child: Column(
            
          children: [
            
            const Gap(10),
      
            Container(
      
              width: 55, height: 210, 
            
              decoration: BoxDecoration(

                color: Themes.accent,

                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                button(() => Markdown.files.newFile(context), FluentIcons.add_24_regular, context, tooltip: "New File"),

                const Gap(6),

                button(() => Markdown.files.loadFile(context), FluentIcons.attach_24_regular, context, tooltip: "Import"),

                const Gap(6),

                button((){
                  showDialog(context: context, builder: (context){
                    return const Configuration();
                  });
                }, FluentIcons.person_24_regular, context, tooltip: "About"),

                const Gap(6),

                button(() => Markdown.files.saveContent(context), FluentIcons.arrow_download_24_regular, context, tooltip: "Export"),

                ],
              )
            ),
          ],
        )
      ),
    );
  } 
}

