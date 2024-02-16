import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';

class Configuration extends StatefulWidget {
  const Configuration({super.key});

  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {

  @override
  Widget build(BuildContext context) {

    return const SimpleDialog(

      shadowColor: Colors.transparent,

      children: [

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
      
      padding: const EdgeInsets.all(30),

      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,

        crossAxisAlignment: CrossAxisAlignment.start,
      
        children: [
      
          // Name & Icon
          const Row(
            
            children: [
          
              Icon(FluentIcons.calendar_week_numbers_24_regular, size: 30),
                      
              Gap(6),
                      
              Text("Notebook v1.3", style: TextStyle(fontSize: 24)),
            ],
          ),

          const Gap(10),

          SizedBox(

            width: 500,

            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MarkdownBody(data: "Rofayel Notebook is a companion that makes your writing enjoyable. It is designed with simplicity in mind. The brain behind; a junior dev with a passion for creating tools that make a difference. Ozan is a newbie project, and we'd love your response! join us on our journey.", styleSheet: MarkdownStyleSheet(p: const TextStyle(fontSize: 16, height: 2))),
              )),
          ),

          const Gap(10),
         
          Text("Adam Rofayel. All rights reserved.", style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.tertiary))
        ],
      ),
    );
  }
}