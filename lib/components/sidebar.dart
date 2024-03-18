import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ozan/views/markdown.dart';
import 'package:ozan/components/components.dart';

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

        height: MediaQuery.of(context).size.height - 80,
        
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,

          mainAxisAlignment: MainAxisAlignment.end,
            
          children: [
                  
            Container(
                  
              decoration: const BoxDecoration(

                color: Colors.transparent,

              ),

              child: Column(

                children: [

                button(() => Markdown.files.loadFile(context), FluentIcons.attach_32_filled, context, tooltip: "Open"),

                const Gap(14),

                button(() => Markdown.files.saveContent(context), FluentIcons.arrow_down_32_filled, context, tooltip: "Save"),

                ],
              )
            ),
          ],
        )
      ),
    );
  } 
}

