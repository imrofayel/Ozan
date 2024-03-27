import 'package:flutter/cupertino.dart';
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
          
              Icon(CupertinoIcons.pencil_outline, size: 30),
                      
              Gap(6),
                      
              Text("Rofayel Notebook v4.0", style: TextStyle(fontSize: 20, fontFamily: 'Inter')),
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
                    padding: const EdgeInsets.all(8.0),
                    child: MarkdownBody(data: "simple, elegant, enjoyable", styleSheet: MarkdownStyleSheet(p: const TextStyle(fontSize: 38, height: 2, fontStyle: FontStyle.italic))),
                  ),

                  const Gap(14),

                  RichText(

                    text: TextSpan(

                      children: [

                        TextSpan(text: 'by Naveed azhar', style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Theme.of(context).colorScheme.tertiary, fontFamily: 'EB Garamond', fontWeight: FontWeight.w500)),
                      ]
                    )
                  ),
                ],
              )),
          ),
        ],
      ),
    );
  }
}