import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:ozan/home_window.dart';
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

        height: MediaQuery.of(context).size.height - 60,
        
        child: Padding(

          padding: const EdgeInsets.all(16),

          child: Column(
          
            crossAxisAlignment: CrossAxisAlignment.end,
          
            mainAxisAlignment: MainAxisAlignment.end,
              
            children: [
                    
              Row(children: [ button(() => Markdown.files.loadFile(context), CupertinoIcons.control, context, tooltip: "Open")]) ,
                          
              const Gap(14),
                          
              Row(children: [ button(() => Markdown.files.saveContent(context), CupertinoIcons.down_arrow, context, tooltip: "Export")]),
            ],
          ),
        )
      ),
    );
  } 
}

