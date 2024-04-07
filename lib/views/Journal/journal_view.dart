import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ozan/components/snackbar.dart';
import 'package:ozan/db/journal_db/journal.dart';
import 'package:ozan/db/journal_db/journal_db_provider.dart';
import 'package:ozan/views/Journal/editor.dart';
import 'package:ozan/views/Journal/editor_update.dart';
import 'package:page_transition/page_transition.dart';
import 'package:popover/popover.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';


class JournalView extends StatefulWidget {
  
  const JournalView({super.key});

  @override
  State<JournalView> createState() => _JournalViewState();
}

class _JournalViewState extends State<JournalView> {

  List<String> questions = [

    "What happened today?",

    "Things I am grateful for...",

    "Daily affirmations"

  ];

  @override
  void initState(){    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<JournalDatabaseProvider>(

      builder: (context, value, child){
      
      return Scaffold(

        appBar: AppBar(

          leadingWidth: 80,

          leading: IconButton.filled(onPressed: (){
            Navigator.pop(context);
          }, 
          
          icon: Icon(CupertinoIcons.arrow_left, size: 22, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6)), style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), overlayColor: const MaterialStatePropertyAll(Colors.transparent)),
          
          ),
        ),

        body: Column(
          
          children: [

              Row(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  FilledButton(onPressed: () async{
                     if (await value.dbHelper.check(DateFormat('d/M/y').format(DateTime.now()))){

                        // ignore: use_build_context_synchronously
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, duration: const Duration(milliseconds: 300), child: const JournalEditor()));
                     } else{
                      // ignore: use_build_context_synchronously
                      SnackBarUtils.showSnackbar(context, FluentIcons.warning_24_regular, "Today's journal entry has already been recorded, try to update it.");
                     }
                  
                  }, style: ButtonStyle(
                            
                    side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),
                  
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(20)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)),
                          
                    child: Row(
                  
                      children: [
                  
                        Icon(CupertinoIcons.pen, size: 24, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8)),
                  
                        const Gap(6),
                  
                        Text('Capture your thoughts!', textScaler: const TextScaler.linear(1.3), style: TextStyle(color: Theme.of(context).colorScheme.tertiary.withOpacity(1))),
                      ],
                    )),
                ],
              ),
            
              FutureBuilder(
        
                future: value.notesList,
        
                builder: (context, AsyncSnapshot<List<Journal>> snapshot) {
                  
                  if(snapshot.hasData && snapshot.data!.isNotEmpty){
                    
                    return Expanded(

                      child: Column(
                      
                        children: [

                          const Gap(14),
                      
                          FilledButton(onPressed: (){}, style: ButtonStyle(
                            
                            side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),
                      
                            padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), child: Text('${snapshot.data!.length} entries', style: TextStyle(fontSize: 17, color: Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter'))),
                          
                          const Gap(14),
                      
                          Expanded(
                                                    
                            child: Padding(

                              padding: const EdgeInsets.all(12),

                              child: GridView.builder(
                                                        
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 390, mainAxisExtent: 250),
                              
                                scrollDirection: Axis.vertical,
                                              
                                itemCount: snapshot.data!.length,
                                
                                itemBuilder:(context, index) {
                                  
                                  return InkWell(
                              
                                    overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                                                            
                                    highlightColor: Colors.transparent,
                                                                            
                                    splashFactory: null,
                              
                                    onTap: (){
                                      showDialog(context: context, builder:(context) => UpdateJournalEditor(entry: snapshot.data![index]),);
                                    },
                              
                                    child: Container(
                                      
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primary,
                                                              
                                        border: Border.all(color: Theme.of(context).colorScheme.secondary),
                                                              
                                        borderRadius: BorderRadius.circular(14)
                                      ),
                                                              
                                      margin: const EdgeInsets.all(8),
                                                              
                                      padding: const EdgeInsets.all(8),
                                                            
                                      child: Column(
                                      
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      
                                        children: [
                                      
                                          Row(
                              
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              
                                            children: [
                              
                                              FilledButton(onPressed: (){}, style: ButtonStyle(
                                                
                                                side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),
                                                                                  
                                                padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background)), child: Text(DateFormat('d MMMM, yy').format(DateFormat('d/M/y').parse(snapshot.data![index].date),), style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary.withOpacity(1), fontFamily: 'Inter'))),
                              
                                                SizedBox(child: Delete(id: snapshot.data![index].id)),
                                            ],
                                          ),
                                    
                                          const Gap(14),

                                            FilledButton(onPressed: (){}, style: ButtonStyle(
                                                
                                                side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),
                                                                                  
                                                padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background)), child: Text(questions[0], style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter'))),

                                                const Gap(6),
                                    
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(snapshot.data![index].description.split('~~~')[1], textScaler: const TextScaler.linear(1.2), maxLines: 4),
                                          )
                                        ],
                                      )
                                    ),
                                  );
                                },  
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
        
                  else {
                    
                    return Visibility(
        
                      visible: snapshot.connectionState == ConnectionState.done,
        
                      child: Expanded(
                
                        child: Column(
        
                          mainAxisAlignment: MainAxisAlignment.center,
        
                          children: [
        
                            FilledButton(onPressed: (){}, style: ButtonStyle(
                                                
                              side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),
                                                                                  
                              padding: const MaterialStatePropertyAll(EdgeInsets.all(20)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), child: Text('Your canvas is blank', style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8), fontFamily: 'Inter'))),

                            const Gap(100),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ]
          )
        );
      }
    );
  }
}

// ignore: must_be_immutable
class Delete extends StatelessWidget {

  Delete({super.key, required this.id});

  int? id;

  @override
  Widget build(BuildContext context) {

    return Consumer<JournalDatabaseProvider>(builder:(context, value, child) =>

      Builder(
                                                                                  
      builder: (context) {
      
      return IconButton(onPressed: (){
                                                                
        showPopover(context: context,

           barrierColor: Colors.transparent,
           
           backgroundColor: Colors.transparent,
           
           direction: PopoverDirection.left,
          
           shadow: List.empty(),
          
           arrowWidth: 0, arrowHeight: 0,
                                                                  
           bodyBuilder:(context) {
                                                                
            return SizedBox(
                                                                
              child: IconButton(onPressed: (){
                
                value.dbHelper.delete(id);
                                                                      
                value.initDatabase();
                                                                      
                value.setLength();

                Navigator.pop(context);
              }, 
              
              icon: Icon(CupertinoIcons.delete, size: 20, 
              
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8)), 
              
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), padding: const MaterialStatePropertyAll(EdgeInsets.all(13)), shadowColor: const MaterialStatePropertyAll(Colors.transparent), surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent)))                                                 
              );
            },
          );                                                       
         }, icon: const Icon(CupertinoIcons.ellipsis, size: 20), padding: EdgeInsets.zero);
        }
      ),
    );
  }
}

Map<String, dynamic> findLargestStringAndIndex(List<String> strings) {
  if (strings.isEmpty) {
    throw ArgumentError("Input list cannot be empty");
  }

  strings.remove('');

  String largestString = strings.first;
  int largestIndex = 0;

  for (int i = 1; i < strings.length; i++) {
    if (strings[i].length > largestString.length) {
      largestString = strings[i];
      largestIndex = i;
    }
  }

  return {'string': largestString, 'index': largestIndex};
}