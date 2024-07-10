// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ozan/components/components.dart';
import 'package:ozan/file_service/file_service.dart';
import 'package:ozan/file_service/pdf_export.dart';
import 'package:ozan/home_window.dart';
import 'package:page_transition/page_transition.dart';
import 'package:popover/popover.dart';
import 'package:gap/gap.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/db/notes.dart';
import 'package:ozan/markdown/markdown_style.dart';
import 'package:ozan/views/update_view.dart';
import 'package:provider/provider.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: value.notesList,
                builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Opacity(opacity: 0.9, child: Text(greet('Buddy'), textScaler: const TextScaler.linear(1.5))),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: Row(
                                  children: [
                                    FilledButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100.withOpacity(0.2) : Theme.of(context).colorScheme.secondary)),
                                        padding: const MaterialStatePropertyAll(EdgeInsets.all(14)),
                                        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                        shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                                        backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.3) : Theme.of(context).colorScheme.primary),
                                      ),
                                      child: Text('${snapshot.data!.length} entries', style: TextStyle(fontSize: 16, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.8) : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter')),
                                    ),
                                    const Gap(14),

                                    FilledButton(
                                      onPressed: () {
                                        
                                        Markdown.files.loadFile(context);
                                      },

                                      style: ButtonStyle(
                                        side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100.withOpacity(0.2) : Theme.of(context).colorScheme.secondary)),
                                        padding: const MaterialStatePropertyAll(EdgeInsets.all(14)),
                                        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                        shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                                        backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.4) : Theme.of(context).colorScheme.primary),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(CupertinoIcons.folder, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.8) : Theme.of(context).colorScheme.tertiary, size: 18),
                                          const Gap(8),
                                          Text('Open', style: TextStyle(fontSize: 16, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.8) : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter')),
                                        ],
                                      ),
                                    ),

                                    const Gap(10),

                                    FilledButton(
                                      onPressed: () {
                                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, duration: const Duration(milliseconds: 300), child: const Markdown()));
                                      },
                                      style: ButtonStyle(
                                        side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100.withOpacity(0.2) : Theme.of(context).colorScheme.secondary)),
                                        padding: const MaterialStatePropertyAll(EdgeInsets.all(14)),
                                        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                        shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                                        backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.4) : Theme.of(context).colorScheme.primary),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(CupertinoIcons.pencil, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900 : Theme.of(context).colorScheme.tertiary, size: 19),
                                          const Gap(4),
                                          Text('Write', style: TextStyle(fontSize: 16, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.8) : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter')),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Gap(14),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 300),
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                    highlightColor: Colors.transparent,
                                    splashFactory: null,
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return Scaffold(
                                          body: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: SizedBox(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(20.0),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          icon: Icon(CupertinoIcons.arrow_left, size: 22, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6)),
                                                          style: ButtonStyle(
                                                            backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
                                                            side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),
                                                            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 10,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(26),
                                                  child: Update(note: snapshot.data![index]),
                                                ),
                                              ),
                                              const Expanded(flex: 2, child: SizedBox()),
                                            ],
                                          ),
                                        );
                                      }));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                                        border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.8)),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      margin: const EdgeInsets.all(4),
                                      padding: const EdgeInsets.all(6),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              FilledButton(
                                                onPressed: () {},
                                                style: ButtonStyle(
                                                  side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100.withOpacity(0.2) : Theme.of(context).colorScheme.secondary)),
                                                  padding: const MaterialStatePropertyAll(EdgeInsets.all(14)),
                                                  overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                                  shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                                                  backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.2) : Theme.of(context).colorScheme.background),
                                                ),
                                                child: Text(snapshot.data![index].date, style: TextStyle(fontSize: 14.5, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.8) : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter')),
                                              ),
                                              Row(
                                                children: [
                                                  FilledButton(
                                                    onPressed: () async {
                                                      if (snapshot.data![index].favourite == 0) {
                                                        value.dbHelper.update(NotesModel(
                                                          title: snapshot.data![index].title,
                                                          description: snapshot.data![index].description,
                                                          date: snapshot.data![index].date,
                                                          id: snapshot.data![index].id,
                                                          favourite: 1,
                                                          tag: snapshot.data![index].tag,
                                                        ));
                                                      } else if (snapshot.data![index].favourite == 1) {
                                                        value.dbHelper.update(NotesModel(
                                                          title: snapshot.data![index].title,
                                                          description: snapshot.data![index].description,
                                                          date: snapshot.data![index].date,
                                                          id: snapshot.data![index].id,
                                                          favourite: 0,
                                                          tag: snapshot.data![index].tag,
                                                        ));
                                                      }
                                                      value.initDatabase();
                                                      value.setLength();
                                                    },
                                                    style: const ButtonStyle(
                                                      padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                                                      overlayColor: MaterialStatePropertyAll(Colors.transparent),
                                                      shadowColor: MaterialStatePropertyAll(Colors.transparent),
                                                      backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                                                    ),
                                                    child: Tooltip(
                                                      message: 'Bookmark',
                                                      child: Icon(
                                                        snapshot.data![index].favourite == 0 ? CupertinoIcons.bookmark : CupertinoIcons.bookmark_fill,
                                                        color: snapshot.data![index].favourite == 0 ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.tertiary.withOpacity(0.8), size: 19),
                                                    )
                                                  ),
                                                  
                                                  SizedBox(child: Delete(id: snapshot.data![index].id)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Gap(7),

                                          Padding(
                                            padding: const EdgeInsets.only(left: 8),
                                            child: Text(snapshot.data![index].title, style: TextStyle(fontSize: 17, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9))),
                                          ),
                                          const Gap(10),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).colorScheme.background,
                                                border: Border.all(color: Theme.of(context).colorScheme.secondary),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: markdown(snapshot.data![index].description, 1, context),
                                            ),
                                          ),
                                          const Gap(10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              FilledButton(
                                                onPressed: () {},
                                                style: ButtonStyle(
                                                  side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).brightness == Brightness.light ? (getColor(snapshot.data![index].tag))[1] : Theme.of(context).colorScheme.secondary)),
                                                  padding: const MaterialStatePropertyAll(EdgeInsets.all(14)),
                                                  overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                                  shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                                                  backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.light ? getColor(snapshot.data![index].tag)[1] : Theme.of(context).colorScheme.primary),
                                                ),
                                                child: Text(
                                                  snapshot.data![index].tag,
                                                  style: TextStyle(fontSize: 14.3, color: Theme.of(context).brightness == Brightness.light ? getColor(snapshot.data![index].tag)[2] : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter'),
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(right: 6),
                                                child: IconButton(icon: Icon(CupertinoIcons.down_arrow, size: 19, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8)), onPressed: () async{ await PdfExport.generateAndSavePDF(context, snapshot.data![index]);}, style: ButtonStyle(overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), tooltip: 'Export to PDF')
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Visibility(
        
                      visible: snapshot.connectionState == ConnectionState.done,
        
                      child: Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Opacity(opacity: 0.9, child: Text(greet('Buddy'), textScaler: const TextScaler.linear(1.5))),
                              
                              Padding(

                                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),

                                child: Row(
                                
                                  children: [
                                
                                    FilledButton(onPressed: (){}, style: ButtonStyle(
                                                  
                                    side: MaterialStatePropertyAll(BorderSide(color:Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100.withOpacity(0.2) : Theme.of(context).colorScheme.secondary)),
                                                                                  
                                    padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.3) : Theme.of(context).colorScheme.primary)), child: Text('${snapshot.data!.length} entries', style: TextStyle(fontSize: 16, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.8) : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter'))),

                                    const Gap(14),

                                    FilledButton(onPressed: (){
                                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, duration: const Duration(milliseconds: 300), child: const Markdown()));
                                    }, style: ButtonStyle(
                                                  
                                    side: MaterialStatePropertyAll(BorderSide(color:Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100.withOpacity(0.2) : Theme.of(context).colorScheme.secondary)),
                                                                                  
                                    padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.4) : Theme.of(context).colorScheme.primary)), child: Row(
                                      children: [
                                        Icon(CupertinoIcons.pencil, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900 : Theme.of(context).colorScheme.tertiary, size: 19),

                                        const Gap(4),

                                        Text('Write', style: TextStyle(fontSize: 16, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.8) : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter')),
                                      ],
                                    )),                                    
                                  ],
                                ),
                              ),
                            ],
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

    return Consumer<DatabaseProvider>(builder:(context, value, child) =>

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
              
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), padding: const MaterialStatePropertyAll(EdgeInsets.all(10)), shadowColor: const MaterialStatePropertyAll(Colors.transparent), surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent)))                                                 
              );
            },
          );                                                       
         }, icon: const Icon(CupertinoIcons.ellipsis, size: 20), padding: EdgeInsets.zero);
        }
      ),
    );
  }
}

List<Color> getColor(String tag){

  if(tag == 'General'){
      return [
      Colors.grey.shade50.withOpacity(0.4),
      Colors.grey.shade100.withOpacity(0.2),
      Colors.grey.shade900
    ];
  } else if(tag == 'Work'){
      return [
      Colors.red.shade50.withOpacity(0.4),
      Colors.red.shade100.withOpacity(0.2),
      Colors.red.shade900.withOpacity(0.8)
    ];
  } else if(tag == 'Studies'){
    return  [
      Colors.green.shade50.withOpacity(0.4),
      Colors.green.shade100.withOpacity(0.2),
      Colors.green.shade900.withOpacity(0.8)
    ];
  } else if (tag == 'Personal'){
      return [
      Colors.blue.shade50.withOpacity(0.4),
      Colors.blue.shade100.withOpacity(0.2),
      Colors.blue.shade900.withOpacity(0.8)
    ];
  }

  return [
      Colors.blue.shade50.withOpacity(0.2),
      Colors.blue.shade100.withOpacity(0.2),
      Colors.blue.shade900
    ];
}