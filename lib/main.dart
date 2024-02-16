import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ozan/theme/theme_provider.dart';
import 'package:ozan/views/home.dart';
import 'package:provider/provider.dart';

void main() async {
  
  runApp(ChangeNotifierProvider(create: (context) => ThemeSwitcher(), child: const Ozan()));
}

class Ozan extends StatefulWidget {
  const Ozan({super.key});

  @override
  State<Ozan> createState() => _OzanState();
}

class _OzanState extends State<Ozan> {

    @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

        debugShowCheckedModeBanner: false,

        theme: Provider.of<ThemeSwitcher>(context).themeData,
        
        home: Scaffold(

          appBar: AppBar(
             
            title: const SizedBox(
              
              child: Row(
                
                children: [
              
                  Icon(FluentIcons.calendar_week_numbers_24_regular, size: 26),
            
                  Gap(6),
            
                  Text("Notebook", style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
                
            elevation: 0,
                
            actions:
              
              [

                IconButton(onPressed: (){

                  Provider.of<ThemeSwitcher>(context, listen: false).toggleTheme();

                }, icon: const Icon(FluentIcons.weather_sunny_24_regular, size: 26)),
                                
                IconButton(onPressed: (){}, icon: const Icon(FluentIcons.cloud_24_regular, size: 26)),

                const Gap(10),
              
              ],
            ),
          body: const Home(),
        ),
      );
  }
}
