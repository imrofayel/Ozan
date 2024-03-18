import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ozan/database/file_service.dart';
import 'package:ozan/components/components.dart';
import 'package:ozan/components/toolbar.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/db/notes.dart';
import 'package:provider/provider.dart';
import '../markdown/markdown_style.dart';

// ignore: must_be_immutable
class Markdown extends StatefulWidget {

  Markdown({super.key, this.note});

  NotesModel? note;

  static FileService files = FileService(_MarkdownState.page);

  @override
  State<Markdown> createState() => _MarkdownState();

}

class _MarkdownState extends State<Markdown>{

  static TextEditingController page = TextEditingController();

  static TextEditingController pageTitle = TextEditingController();

  static FocusNode _focusNode = FocusNode(); // Declare the FocusNode

  // ignore: unused_field
  static String md = 'Open Editor & Capture your thoughts!'; // Markdown Bodata

  @override
  void initState() {
      page.addListener(() => setState(() {})); 
      _focusNode = FocusNode(); // Assign a FocusNode

      if(widget.note != null){

        setState(() {
          
          pageTitle = TextEditingController(text: widget.note!.title);

          page = TextEditingController(text: widget.note!.description);

        });        
      }

      // else{

      //   setState(() {
          
      //     page = TextEditingController(text: page.text);

      //     pageTitle = TextEditingController(text: 'Creation');
          
      //   });
      // }

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

      return Scaffold(
        
        body: Row(
        
          children: [
        
            Expanded(
            
              flex: 6,
            
              child: SingleChildScrollView(
               
                scrollDirection: Axis.vertical,
        
                child: Column(
                
                  mainAxisAlignment: MainAxisAlignment.center,
                
                  children: [
                    
                    Container(
        
                      decoration: BoxDecoration(
        
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
        
                        borderRadius: const BorderRadius.all(Radius.circular(23)),
        
                        border: Border.all(width: 1, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.4))
        
                      ),
        
                      child: Row(
                        
                        children: [
                      
                          Expanded(child: titleBox(context, controller: pageTitle)),
                      
                          const Gap(20),
                                                    
                          const Gap(15),
                                  
                          FilledButton(onPressed: (){
                                  
                            showDialog(
                              context: context, 
                                  
                              builder: (context){
                                return Editor(note: widget.note);
                              }
                            );
                          }, style: ButtonStyle(
                            
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                            
                            backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.secondary), padding: const MaterialStatePropertyAll(EdgeInsets.all(18)), shadowColor: const MaterialStatePropertyAll(Colors.transparent), overlayColor: const MaterialStatePropertyAll(Colors.transparent)), 
                            
                            child: Row(
        
                              children: [
        
                                Icon(CupertinoIcons.pencil_outline, size: 26, color: Theme.of(context).colorScheme.primary),
        
                                const Gap(10),
        
                                Text('Writer', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20, fontFamily: 'Inter'),)
                              ],
                            )),
        
                          const Gap(15)
                        ],
                      ),
                    ),
                          
                    SizedBox(
                              
                      height: 450,
                              // change md to page.text
                      child: markdown(md, 1.62, context)
                    ),
                            
                      const Gap(10),
                            
                      Padding(
                            
                        padding: const EdgeInsets.fromLTRB(0,0,0,10),
                        
                        child: Row(
                                          
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        children: [
                                          
                          textEncode(context, words: page.text.split(' ').length-1, char: page.text.length, lines: page.text.split('\n').length-1),
                        
                        ],
                      ),
                    ),
                  ],
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

String title(){
  
  String getTitle = 'Untitled';

  if(_MarkdownState.pageTitle.text.isNotEmpty){
    getTitle = _MarkdownState.pageTitle.text;
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

class _EditorState extends State<Editor> {
  
  // int selectedIndex = 0;

  String date = DateTime.now().toString(); 


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
            
            const Row(
      
              children: [
      
                Icon(CupertinoIcons.pencil_outline, size: 28),
            
                Gap(10),
      
                Text("Writer", style: TextStyle(fontSize: 24, fontFamily: 'Inter'),),
              ],
            ),
            IconButton(
              
                onPressed: (){
            
                if(_MarkdownState.pageTitle.text.isNotEmpty && _MarkdownState.page.text.isNotEmpty){
            
                if(widget.note != null){
            
                value.dbHelper.update(NotesModel(title: _MarkdownState.pageTitle.text, description: _MarkdownState.page.text, date: date, id: widget.note!.id));
              
                value.initDatabase();
              
                  value.setLength();
                } 
            
                else{
            
                  value.dbHelper.insert(NotesModel(title: _MarkdownState.pageTitle.text, description: _MarkdownState.page.text, date: date));
              
                  value.initDatabase();
              
                  value.setLength();
                }
            
                Navigator.of(context).pop();
            
                } else{
            
                  showDialog(context: context, builder:(context) {
                    
                    return CupertinoAlertDialog(content: Padding(
                      
                      padding: const EdgeInsets.all(5.0),
                      
                      child: Text("Please enter title and description", style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.tertiary, fontFamily: "Inter", height: 1.4), textAlign: TextAlign.left),
                      ));
                    });
            
                  }
            
                }, 
              
              
                icon: const Icon(CupertinoIcons.square_arrow_down)

                )
          ],
        ),
      
        titlePadding: const EdgeInsets.fromLTRB(30, 30, 20, 0),
      
        children: [
      
          SizedBox(
      
            height: 480,
      
            width: 550,
      
            child: Column(
      
              children: [
      
                  toolbar(_MarkdownState.page, context),
      
                    const Gap(8),
            
                    Column(
            
                      mainAxisAlignment: MainAxisAlignment.center,
      
                      crossAxisAlignment: CrossAxisAlignment.center,
            
                      children: [
            
                        Padding(
      
                          padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
      
                          child: Container(
                          
                            height: 390,
                          
                            decoration: BoxDecoration(
                              
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              
                              // TextBox
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
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
                                          _MarkdownState.page.text += '\n';
                                        });
                                      },
                                      
                                      onChanged: (text) {
                                        setState(() {
                                          _MarkdownState.md = text;
                                        });
                                      },
                                      
                                      controller: _MarkdownState.page, 
                                      
                                      focusNode: _MarkdownState._focusNode,
                                                                    
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