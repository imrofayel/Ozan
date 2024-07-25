// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ozan/components/components.dart';
import 'package:ozan/components/filter_db.dart';
import 'package:ozan/components/preferences.dart';
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
    return Consumer<AppState>(
      builder: (context, value, child) =>
      Consumer<DatabaseProvider>(
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

                       List<NotesModel> notes = snapshot.data!;

                      // Sort the notes by date in descending order
                      notes.sort((a, b) {
                        DateTime dateA = DateFormat('d MMM, yy').parse(a.date);
                        DateTime dateB = DateFormat('d MMM, yy').parse(b.date);
                        return dateB.compareTo(dateA);
                      });

                      final filterState = Provider.of<FilterState>(context);

                      notes = filterState.showFavouritesOnly
                          ? snapshot.data!.where((note) => note.favourite == 1).toList()
                          : snapshot.data!;
                          
                      return Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Opacity(opacity: 0.9, child: Text(greet(Provider.of<AppState>(context, listen: false).userName), textScaler: const TextScaler.linear(1.5), style: TextStyle(color: Colors.blue.shade900.withOpacity(0.9), decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.wavy, decorationThickness: 2, decorationColor: Colors.blue.shade200.withOpacity(0.4)))),

                                const Gap(10),

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
                                        child: Text('${notes.length} entries', style: TextStyle(fontSize: 16, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.9) : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter')),
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
                                            Icon(CupertinoIcons.folder, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.9) : Theme.of(context).colorScheme.tertiary, size: 18),
                                            const Gap(8),
                                            Text('Open', style: TextStyle(fontSize: 16, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.9) : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter')),
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
                                            Text('Write', style: TextStyle(fontSize: 16, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.9) : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter')),
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
                                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 340),
                                  scrollDirection: Axis.vertical,
                                  itemCount: notes.length,
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
                                                  flex: MediaQuery.of(context).size.width > 850 ? 2 : 1,
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
                                                            icon: Icon(CupertinoIcons.arrow_left, size: 22, color: Theme.of(context).colorScheme.tertiary),
                                                            style: const ButtonStyle(
                                                              backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                                                              overlayColor: MaterialStatePropertyAll(Colors.transparent),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: MediaQuery.of(context).size.width > 850 ? 10 : 9,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(26),
                                                    child: Update(note: notes[index]),
                                                  ),
                                                ),
                                                Expanded(flex: MediaQuery.of(context).size.width > 850 ? 2 : 0,child: const SizedBox()),
                                              ],
                                            ),
                                          );
                                        }));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.primary,
                                          border: Border.all(color: Theme.of(context).colorScheme.secondary),
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
                                                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                                    side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100.withOpacity(0.2) : Theme.of(context).colorScheme.secondary)),
                                                    padding: const MaterialStatePropertyAll(EdgeInsets.all(8)),
                                                    overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                                    shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                                                    backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.2) : Theme.of(context).colorScheme.background),
                                                  ),
                                                  child: Text(notes[index].date, style: TextStyle(fontSize: 15, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900 : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter')),
                                                ),
                                                Row(
                                                  children: [
                                                    FilledButton(
                                                      onPressed: () async {
                                                        if (notes[index].favourite == 0) {
                                                          value.dbHelper.update(NotesModel(
                                                            title: notes[index].title,
                                                            description: notes[index].description,
                                                            date: notes[index].date,
                                                            id: notes[index].id,
                                                            favourite: 1,
                                                            tag: notes[index].tag,
                                                          ));
                                                        } else if (notes[index].favourite == 1) {
                                                          value.dbHelper.update(NotesModel(
                                                            title: notes[index].title,
                                                            description: notes[index].description,
                                                            date: notes[index].date,
                                                            id: notes[index].id,
                                                            favourite: 0,
                                                            tag: notes[index].tag,
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
                                                          notes[index].favourite == 0 ? CupertinoIcons.bookmark : CupertinoIcons.bookmark_fill,
                                                          color: notes[index].favourite == 0 ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.tertiary.withOpacity(0.9), size: 19),
                                                      )
                                                    ),
                                                    
                                                    SizedBox(child: Delete(id: notes[index].id)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Gap(7),
      
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8),
                                              child: Text(notes[index].title, style: TextStyle(fontSize: 17.5, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.95))),
                                            ),
                                            const Gap(10),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).colorScheme.background,
                                                  border: Border.all(color: Theme.of(context).colorScheme.secondary),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: markdown(notes[index].description, 1, context),
                                              ),
                                            ),
                                            const Gap(10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                FilledButton(
                                                  onPressed: () {},
                                                  style: ButtonStyle(
                                                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                                    side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).brightness == Brightness.light ? (getColor(notes[index].tag, context))[1] : Theme.of(context).colorScheme.secondary)),
                                                    padding: const MaterialStatePropertyAll(EdgeInsets.all(8)),
                                                    overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                                    shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                                                    backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.light ? getColor(notes[index].tag, context)[0] : Theme.of(context).colorScheme.primary),
                                                  ),
                                                  child: Text(
                                                    notes[index].tag,
                                                    style: TextStyle(fontSize: 14.3, color: Theme.of(context).brightness == Brightness.light ? getColor(notes[index].tag, context)[2] : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter'),
                                                  ),
                                                ),
    
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 6),
                                                  child: IconButton(icon: Icon(CupertinoIcons.down_arrow, size: 20, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.95)), onPressed: () async{ await PdfExport.generateAndSavePDF(context, notes[index]);}, style: ButtonStyle(overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), tooltip: 'Export to PDF')
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
      
                                Opacity(opacity: 0.9, child: Text(greet(Provider.of<AppState>(context, listen: false).userName), textScaler: const TextScaler.linear(1.5), style: TextStyle(color: Colors.blue.shade900.withOpacity(0.9), decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.wavy, decorationThickness: 2, decorationColor: Colors.blue.shade200.withOpacity(0.4)))),
                                
                                Padding(
      
                                  padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
      
                                  child: Row(
                                  
                                    children: [
                                  
                                      FilledButton(onPressed: (){}, style: ButtonStyle(
                                                    
                                      side: MaterialStatePropertyAll(BorderSide(color:Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100.withOpacity(0.2) : Theme.of(context).colorScheme.secondary)),

                                      padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.3) : Theme.of(context).colorScheme.primary)), child: Text('0 entries', style: TextStyle(fontSize: 16, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.9) : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter'))),
      
                                      const Gap(14),
      
                                      FilledButton(onPressed: (){
                                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, duration: const Duration(milliseconds: 300), child: const Markdown()));
                                      }, style: ButtonStyle(
                                                    
                                      side: MaterialStatePropertyAll(BorderSide(color:Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100.withOpacity(0.2) : Theme.of(context).colorScheme.secondary)),
                                                                                    
                                      padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.4) : Theme.of(context).colorScheme.primary)), child: Row(
                                        children: [
                                          Icon(CupertinoIcons.pencil, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900 : Theme.of(context).colorScheme.tertiary, size: 19),
      
                                          const Gap(4),
      
                                          Text('Write', style: TextStyle(fontSize: 16, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900.withOpacity(0.9) : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter')),
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
      ),
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
              
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9)), 
              
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

List<Color> getColor(String tag, context){

  if(tag == 'General'){
      return [
      const Color.fromRGBO(247, 247, 246, 1),
      const Color.fromARGB(255, 239, 239, 238),
      const Color.fromRGBO(31, 28, 25, 1)
    ];
  } else if(tag == 'Work'){
      return [
      const Color.fromRGBO(255, 234, 236, 1),
      const Color.fromARGB(255, 255, 223, 226),
      const Color.fromRGBO(140, 40, 67, 1),
    ];
  } else if(tag == 'Studies'){
    return  [
      const Color.fromRGBO(221, 251, 235, 1),
      const Color.fromARGB(255, 207, 245, 209),
      Colors.green.shade900.withOpacity(0.9)
    ];
  } else if (tag == 'Personal'){
      return [
      Colors.blue.shade50.withOpacity(0.4),
      Colors.blue.shade200.withOpacity(0.4),
      Colors.blue.shade900
    ];
  }

  return [
      Colors.blue.shade50.withOpacity(0.6),
      Colors.blue.shade200.withOpacity(0.6),
      Colors.blue.shade900
    ];
}