import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ozan/views/home.dart';
import 'package:ozan/theme/theme.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() async {
  runApp(const Ozan());
  doWhenWindowReady(() {
    final win = appWindow;
    win.alignment = Alignment.center;
    win.minSize = const Size(1050, 600);
    win.maximize();
    win.title = "Ozan";
    win.show();
  });
}

class Ozan extends StatefulWidget {
  const Ozan({super.key});

  @override
  State<Ozan> createState() => _OzanState();
}

class _OzanState extends State<Ozan> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        home: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(44),
            child: AppBar(
      
              title: SizedBox(
                
                child: Row(
                  
                  children: [
                
                    const Icon(Iconsax.unlimited, size: 26),
              
                    const Gap(6),
              
                    const Text("Ozan", style: TextStyle(fontSize: 20)),
      
                    const Gap(6),
      
                    FilledButton.tonal(onPressed: (){}, style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(60, 30)), padding: MaterialStatePropertyAll(EdgeInsets.zero)), child: const Text("Beta"))
                  ],
                ),
              ),
      
      
              backgroundColor: Themes.background,
              elevation: 0,
      
              actions: const[
                      MinimizeButton(),
                      MaximizeButton(),
                      CloseButton(),
                    ],
              )
            ),
          body: const Home(),
        ),
      );
  }
}


class MinimizeButton extends StatelessWidget {
  const MinimizeButton({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: IconButton(
        icon: const Icon(Iconsax.minus, size: 22),
        onPressed: () {
          appWindow.minimize();
        },
      ),
    );
  }
}

class MaximizeButton extends StatelessWidget {
  const MaximizeButton({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: IconButton(
        icon: const Icon(Iconsax.copy, size: 22),
        onPressed: () {
          if (appWindow.isMaximized) {
            appWindow.restore();
          } else {
            appWindow.maximize();
          }
        },
      ),
    );
  }
}

class CloseButton extends StatelessWidget {
  const CloseButton({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: IconButton(
        icon: const Icon(Iconsax.close_circle, size: 22),
        onPressed: () {
          appWindow.close();
        },
      ),
    );
  }
}
