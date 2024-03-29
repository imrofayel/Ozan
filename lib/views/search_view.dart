import 'package:flutter/material.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  @override
  Widget build(BuildContext context) {

    TextEditingController controller = TextEditingController();

    return Consumer<DatabaseProvider>(builder:(context, value, child) =>
      
      SimpleDialog(

        backgroundColor: Theme.of(context).colorScheme.primary,

        surfaceTintColor: Colors.transparent,
      
        shadowColor: Colors.transparent,
      
        children: [
      
          Container(

            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, border: Border.all(color: Theme.of(context).colorScheme.secondary), borderRadius: BorderRadius.circular(20)),
            
            child: const Placeholder(),

          ),
      
        ]
      ),
    );
  }
}