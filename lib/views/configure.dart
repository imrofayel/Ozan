import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ozan/components/components.dart';
import 'package:ozan/theme/theme.dart';
import 'package:simple_icons/simple_icons.dart';

class Configuration extends StatefulWidget {
  const Configuration({super.key});

  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(

      shadowColor: Colors.transparent,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      title: const Text("About"),

      children: [

        SizedBox(
          height: 400,
          width: 600,
          child: Column(
            children: [
              Row(

                mainAxisAlignment: MainAxisAlignment.start,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Expanded(
                    flex: 1,
                    child: NavigationMenu(
                      onItemSelected: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                  ),

                  Expanded(
                    flex: 9,
                    child: selectedScreen(selectedIndex),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget selectedScreen(int index) {

    switch (index) {

      case 0:
        return const Info();

      default:
        return const SizedBox();
    }
  }
}

class NavigationMenu extends StatelessWidget {
  
  final ValueChanged<int> onItemSelected;

  const NavigationMenu({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {

    return Column(

      children: [

        IconButton(onPressed: (){
          onItemSelected(0);
        }, icon: const Icon(Iconsax.setting)),
      ],
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
      
      padding: const EdgeInsets.all(20),

      margin: const EdgeInsets.fromLTRB(0, 0, 12, 0),

      decoration: BoxDecoration(
        color: Themes.accent.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(

        mainAxisAlignment: MainAxisAlignment.start,

        crossAxisAlignment: CrossAxisAlignment.start,
      
        children: [
      
          // Name & Icon
          Row(
      
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
            children: [
              
              Row(
                children: [
                  const Icon(Iconsax.unlimited, size: 26),

                  const Gap(5),

                  Text("Ozan", style: TextStyle(fontSize: 22, color: Themes.text.withOpacity(0.9))),
                ],
              ),
              
              tonalButton(fn: (){}, text: "Updates", icon: Iconsax.refresh, size: const Size(145, 50), textSize: 17, iconSize: 19),
            ],
          ),
          
          Text("Current version: v1.2.5", style: TextStyle(fontSize: 16, color: Themes.text.withOpacity(0.9))),

          const Gap(15),

          Container(

            height: 160, width: 500,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Themes.accent.withOpacity(0.4),
            ),

            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MarkdownBody(data: "Ozan is a companion that makes your writing enjoyable. It is designed with simplicity in mind. The brain behind Ozan; a junior dev with a passion for creating tools that make a difference. Ozan is a newbie project, and we'd love your response! Whether you're a fellow developer, a user with feedback, join us on our journey.", styleSheet: MarkdownStyleSheet(p: const TextStyle(fontSize: 15.5, height: 2)),),
                )),
            ),
          ),

          const Gap(15),

          Row(
            
            children: [

              IconButton(onPressed: (){}, icon: const Icon(SimpleIcons.github, color: SimpleIconColors.github)),

              const Gap(6),

              IconButton(onPressed: (){}, icon: const Icon(SimpleIcons.x, color: SimpleIconColors.x))
            ],
          ),

          const Gap(20),

          Row(
            children: [
              const Icon(Iconsax.copyright, size: 20),

              const Gap(5),

              Text("${DateTime.now().year} Adam Rofayel. All rights reserved.", style: TextStyle(fontSize: 16, color: Themes.text.withOpacity(0.9))),
            ],
          )
        ],
      ),
    );
  }
}