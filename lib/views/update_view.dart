import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:ozan/components/style_components.dart';
import 'package:ozan/components/snackbar.dart';
import 'package:ozan/file_service/file_service.dart';
import 'package:ozan/components/components.dart';
import 'package:ozan/components/toolbar.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/db/notes.dart';
import 'package:provider/provider.dart';
import '../markdown/markdown_style.dart';

// ignore: must_be_immutable
class Update extends StatefulWidget {

  Update({super.key, this.note});

  NotesModel? note;

  static FileService files = FileService(_UpdateState.page, _UpdateState.pageTitle);

  @override
  State<Update> createState() => _UpdateState();

}
class _UpdateState extends State<Update>{

  static TextEditingController page = TextEditingController();

  static TextEditingController pageTitle = TextEditingController();

  static FocusNode _focusNode = FocusNode(); // Declare the FocusNode

  // ignore: unused_field
  static String md = 'Capture your thoughts!'; // Markdown Bodata

  @override
  void initState() {
      page.addListener(() => setState(() {})); 
      _focusNode = FocusNode(); // Assign a FocusNode

      if(widget.note != null){

        setState(() {
          
          pageTitle = TextEditingController(text: widget.note!.title);

          page = TextEditingController(text: widget.note!.description);

          md = (widget.note!.description).toString();

        });        
      }

      super.initState();
}

  @override
  void dispose() {
    //  page.dispose(); // Dispose the TextEditingController
    //  _focusNode.dispose(); // Dispose the FocusNode
      super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<DatabaseProvider>(builder:(context, value, child){

      return Padding(

        padding: const EdgeInsets.all(6),

        child: Container(
        
          decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9)), borderRadius: BorderRadius.circular(12)),
        
          child: Scaffold(
            
            backgroundColor: Colors.transparent,
        
            body: Row(
              children: [

                const Expanded(flex: 1, child: SizedBox()),

                Expanded(

                  flex: 8,

                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                    
                      children: [
                    
                        Expanded(
                        
                          flex: 6,
                        
                          child: SingleChildScrollView(
                           
                            scrollDirection: Axis.vertical,
                    
                            child: Column(
                            
                              mainAxisAlignment: MainAxisAlignment.center,
                            
                              children: [
                                
                                Row(
                                  
                                  children: [
                                
                                    Expanded(child: titleBox(context, controller: pageTitle, enabled: true)),
                                                    
                                    Tooltip(
                                      
                                      message: 'Writer',
                              
                                      child: FilledButton(onPressed: (){
                                              
                                        showDialog(
                                          context: context, 
                                              
                                          builder: (context){
                                            return Editor(note: widget.note);
                                          }
                                        );
                                      }, 
                                      
                                      style: ButtonStyle(
                                        
                                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide.none)),
                                        
                                        backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background.withOpacity(0.3)), padding: const MaterialStatePropertyAll(EdgeInsets.all(15)), shadowColor: const MaterialStatePropertyAll(Colors.transparent), overlayColor: const MaterialStatePropertyAll(Colors.transparent)), 
                                        
                                        child: Icon(CupertinoIcons.pen, color: Theme.of(context).colorScheme.tertiary, size: 26)),
                                    ),
                                        
                                    const Gap(15)
                                  ],
                                ),
                              
                                const Gap(8),
                              
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent
                                  ),
                                  child: ExpansionTile(leading: const Icon(CupertinoIcons.book), title: Text('Table Of Contents', style: TextStyle(color: Colors.deepPurple.shade400, fontWeight: FontWeight.bold, fontSize: 16, decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.wavy, decorationColor: Colors.deepPurple.shade100, decorationThickness: 2.3)), children: [Padding(
                                    padding: const EdgeInsets.only(bottom: 20, left: 15),
                                    child: MarkdownBody(data: generateTableOfContents(page.text), styleSheet: MarkdownStyle.style(context, 1.25), extensionSet: MarkdownStyle.extension()),
                                  )]),
                                ),
                                      
                                SizedBox(
                                          
                                  height: 440,
                                  child: markdown(page.text, 1.14, context)
                                ),
                                        
                                  const Gap(10),
                              
                                  Row(
                                                    
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  
                                  children: [
                                                    
                                    textEncode(context, words: page.text.split(' ').length-1, char: page.text.length, lines: page.text.split('\n').length-1),
                                  
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                    
                        const Expanded(flex: 1, child: SizedBox()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    );
}
}

String title(){
  
  String getTitle = 'Untitled${DateTime.now().microsecond}';

  if(_UpdateState.pageTitle.text.isNotEmpty){
    getTitle = _UpdateState.pageTitle.text;
  }

  return getTitle;
}


// Editor Dialogue
// ignore: must_be_immutable
class Editor extends StatefulWidget {

  NotesModel? note;

  Editor({super.key, this.note});

  @override
  State<Editor> createState() => _EditorState();
}

// ignore: constant_identifier_names
enum Tags {General, Studies, Work, Personal}

class _EditorState extends State<Editor> {
  
  String date = DateFormat('d MMM, yy').format(DateTime.now()); 

  Tags selected = Tags.General;

  getTag(){

    if(widget.note!.tag == 'General'){
      selected = Tags.General;
    } else if(widget.note!.tag == 'Work'){
      selected = Tags.Work;
    } else if(widget.note!.tag == 'Studies'){
      selected = Tags.Studies;
    } else if(widget.note!.tag == 'Personal'){
      selected = Tags.Personal;
    }
  }

    @override
  void initState() {
    super.initState();
    getTag();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<DatabaseProvider>(builder:(context, value, child){

      return SimpleDialog(
      
        elevation: 0,
      
        shadowColor: Colors.transparent,
      
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      
        title: Row(
      
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
          children: [
            
            Row(
                  
              children: [
                  
                Icon(CupertinoIcons.pencil_outline, size: 25, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9)),
            
                const Gap(10),
                  
                Text("Writer", style: TextStyle(fontSize: 20, fontFamily: 'Inter', color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9)),),
              ],
            ),

              FilledButton(

                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue.shade50.withOpacity(0.3)), padding: const MaterialStatePropertyAll(EdgeInsets.all(16)),
                    
                    side: MaterialStatePropertyAll(BorderSide(width: 1, color: Colors.blue.shade100.withOpacity(0.2))),

                    overlayColor: const MaterialStatePropertyAll(Colors.transparent),

                    shadowColor: const MaterialStatePropertyAll(Colors.transparent)
                    
                    ),
              
                onPressed: (){
            
                if(_UpdateState.page.text.isNotEmpty){
            
                if(widget.note != null){
            
                value.dbHelper.update(NotesModel(title:  _UpdateState.pageTitle.text.isNotEmpty ? _UpdateState.pageTitle.text : 'Untitled', description: _UpdateState.page.text, date: date, id: widget.note!.id, favourite: widget.note!.favourite, tag: selected.name));
              
                value.initDatabase();
              
                value.setLength();
                } 
            
                else{
            
                  value.dbHelper.insert(NotesModel(title: _UpdateState.pageTitle.text.isNotEmpty ? _UpdateState.pageTitle.text : 'Untitled', description: _UpdateState.page.text, date: date, 
                  favourite: 0, tag: widget.note!.tag));
              
                  value.initDatabase();
              
                  value.setLength();
                }
                        
                }

                else{
                  SnackBarUtils.showSnackbar(context, CupertinoIcons.pencil_slash, "Please enter title and description");
                }
            
                }, 
              
              
                child: Text('Save', style: TextStyle(fontFamily: 'Inter', fontSize: 16, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9)))

                )
          ],
        ),
      
        titlePadding: const EdgeInsets.fromLTRB(30, 30, 20, 0),
      
        children: [
      
          SizedBox(
      
            height: 480,
      
            width: 600,
      
            child: Column(
      
              children: [

                  SegmentedButton(segments: const[

                    ButtonSegment(value: Tags.General, label: Text('General', style: TextStyle(fontSize: 15))),

                    ButtonSegment(value: Tags.Studies, label: Text('Studies', style: TextStyle(fontSize: 15))),

                    ButtonSegment(value: Tags.Work, label: Text('Work', style: TextStyle(fontSize: 15))),

                    ButtonSegment(value: Tags.Personal, label: Text('Personal', style: TextStyle(fontSize: 15))),

                  ], selected: <Tags>{selected},
                  
                  onSelectionChanged: (Set<Tags> newSelection) => {
                    setState(() {
                      selected = newSelection.first;
                    })
                  },
                  
                  style: ButtonStyle(
                      side: MaterialStatePropertyAll(BorderSide(
                        color: Theme.of(context).brightness == Brightness.light
                                    ? Colors.blue.shade100.withOpacity(0.2)
                                    : Theme.of(context).colorScheme.secondary)),
                        padding: const MaterialStatePropertyAll(EdgeInsets.all(14)),
                        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                        shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                        backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.blue.shade50.withOpacity(0.3)
                                    : Theme.of(context).colorScheme.primary)),
                  ),

      
                  toolbar(_UpdateState.page, context),
                  
                    Column(
            
                      mainAxisAlignment: MainAxisAlignment.center,
      
                      crossAxisAlignment: CrossAxisAlignment.center,
            
                      children: [
            
                        Padding(
      
                          padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
      
                          child: Container(
                          
                            height: 370,
                          
                            decoration: BoxDecoration(
                              
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              
                              // TextBox
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
                            ),
                          
                            child: Padding(
                            
                              padding: const EdgeInsets.all(6),
                              // SCSV
                              child: Column(
                                
                                mainAxisAlignment: MainAxisAlignment.start,
                              
                                crossAxisAlignment: CrossAxisAlignment.start,
                              
                                children: [ 
                              
                                    SingleChildScrollView(
                          
                                      scrollDirection: Axis.vertical,
                          
                                      child: textField(context,
                                              
                                      lines: 9,
                                              
                                      onSubmitted: (text) {
                                        setState(() {
                                          _UpdateState.page.text += '\n';
                                        });
                                      },
                                      
                                      onChanged: (text) {
                                        setState(() {
                                          _UpdateState.md = text;
                                        });
                                      },
                                      
                                      controller: _UpdateState.page, 
                                      
                                      focusNode: _UpdateState._focusNode,
                                                                    
                                      color: Colors.transparent,
                                      ),
                                    ),
                                ]
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          )
        ],
      );
    }
    );
  }
}