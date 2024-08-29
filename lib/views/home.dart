import 'package:flutter/material.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/components/sidebar&AI.dart';
import 'package:ozan/providers/navigation_provider.dart';
import 'package:provider/provider.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return Consumer<Navigation>(builder: (context, value, child) =>
      
      Consumer<DatabaseProvider>(builder:(context, value, child){
      
        return Scaffold(
                
          body: Row(
          
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              
              const Expanded(flex: 1, child: Sidebar()),
                
              Expanded(flex: 24, child: Provider.of<Navigation>(context).current),
      
            ],
          ),
        );
      }
      ),
    );
  }
}