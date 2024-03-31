import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:ozan/db/journal_db/journal.dart';
import 'package:ozan/db/journal_db/journal_db_provider.dart';
import 'package:ozan/views/Journal/editor_component.dart';
import 'package:provider/provider.dart';

class JournalEditor extends StatefulWidget {
  const JournalEditor({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JournalEditorState createState() => _JournalEditorState();
}

class _JournalEditorState extends State<JournalEditor> {

  final PageController _pageController = PageController();

  int _currentPage = 0;

  List<TextEditingController> controller = [

    TextEditingController(),

    TextEditingController(),

    TextEditingController()

  ];

  List<String> questions = [

    "What happened today?",

    "Things I am grateful for...",

    "Daily affirmations"

  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<JournalDatabaseProvider>(builder:(context, value, child){

      return Scaffold(
      
        backgroundColor: Theme.of(context).colorScheme.background,

        appBar: AppBar(

          leadingWidth: 80,

          leading: IconButton.filled(onPressed: (){
            Navigator.pop(context);
          }, 
          
          icon: Icon(CupertinoIcons.arrow_left, size: 22, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6)), style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), overlayColor: const MaterialStatePropertyAll(Colors.transparent)),
          
          ),

          actions: [

          Row(
          
            mainAxisAlignment: MainAxisAlignment.center,
          
            children: [
          
              FilledButton(onPressed:
          
                    controller[0].text.isNotEmpty && controller[1].text.isNotEmpty && controller[2].text.isNotEmpty ? (){
          
                            value.dbHelper.insert(Journal(description: "${controller[0].text}~~~${controller[0].text}~~~${controller[2].text}", date: DateFormat('d/M/y').format(DateTime.now())));
          
                            value.initDatabase();
                            
                            value.setLength();
          
                            Navigator.pop(context);
          
                        } : null,
                                        
                        style: ButtonStyle(
              
                          side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),
              
                          padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), 
                          
                          child: Row(
              
                            children: [
              
                              Icon(CupertinoIcons.arrow_turn_up_right, size: 20, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8)),
          
                              const Gap(6),
              
                              Text('Done', textScaler: const TextScaler.linear(1.3), style: TextStyle(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8))),
          
                            ],
                        )),

                        const Gap(15),
                    ],
                  ),
          ],
        ),
      
        body: Row(
        
          children: [
      
            Expanded(
      
              flex: 4,
      
              child: Center(
      
                child: IconButton(
                      
                      onPressed: _currentPage > 0
                          ? () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linearToEaseOut,
                              );
                            }
                          : null,
                
                      icon: Padding(
      
                        padding: const EdgeInsets.all(6),
                        
                        child: Icon(CupertinoIcons.arrow_left, size: 26, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6))),
                
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), shadowColor: const MaterialStatePropertyAll(Colors.transparent), overlayColor: const MaterialStatePropertyAll(Colors.transparent)),
                ),
              ),
            ),
        
            Expanded(
      
              flex: 8,
        
              child: PageView.builder(
        
                controller: _pageController,
        
                itemCount: 3,
        
                itemBuilder: (context, index) {
        
                  return EditorComponent(controller: controller[_currentPage], question: questions[_currentPage]);
                },
        
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),
        
            Expanded(
      
              flex: 4,
      
              child: Center(
      
                  child: IconButton(

                          onPressed: (){

                            if (_currentPage < 2) {

                              _pageController.nextPage(
                                   duration: const Duration(milliseconds: 300),
                                   curve: Curves.linearToEaseOut,
                              );

                            } else {
                              null;
                            }
                          },
                        
                        icon: Padding(
      
                          padding: const EdgeInsets.all(6),
      
                          child: Icon(CupertinoIcons.arrow_right, size: 26, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6)),
                        ),
                  
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), shadowColor: const MaterialStatePropertyAll(Colors.transparent), overlayColor: const MaterialStatePropertyAll(Colors.transparent)),
                      ),
                ),
              ),
          ],
        ),
      );
    }
    );
  }
}
