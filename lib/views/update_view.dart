import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:ozan/components/snackbar.dart';
import 'package:ozan/database/file_service.dart';
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
        
                        border: Border.all(color: Theme.of(context).colorScheme.secondary)
        
                      ),
        
                      child: Row(
                        
                        children: [
                      
                          Expanded(child: titleBox(context, controller: pageTitle)),
                      
                          const Gap(20),

                          FilledButton(onPressed: (){
                                  
                            showDialog(
                              context: context, 
                                  
                              builder: (context){
                                return Editor(note: widget.note);
                              }
                            );
                          }, 
                          
                          style: ButtonStyle(
                            
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: BorderSide.none)),
                            
                            backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), padding: const MaterialStatePropertyAll(EdgeInsets.all(18)), shadowColor: const MaterialStatePropertyAll(Colors.transparent), overlayColor: const MaterialStatePropertyAll(Colors.transparent)), 
                            
                            child: Row(
        
                              children: [
        
                                Icon(CupertinoIcons.pencil_outline, size: 26, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8)),
        
                                const Gap(10),
        
                                Text('Writer', style: TextStyle(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8), fontSize: 20, fontFamily: 'Inter'))
                              ],
                            )),
        
                          const Gap(15)
                        ],
                      ),
                    ),
                          
                    SizedBox(
                              
                      height: 485,
                              // change md to page.text
                      child: markdown(page.text, 1.30, context)
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
          ],
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

class _EditorState extends State<Editor> {
  
  String date = DateFormat('d MMM, yy').format(DateTime.now()); 

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

              FilledButton(

                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), padding: const MaterialStatePropertyAll(EdgeInsets.all(16)),
                    
                    side: MaterialStatePropertyAll(BorderSide(width: 1, color: Theme.of(context).colorScheme.secondary)),

                    overlayColor: const MaterialStatePropertyAll(Colors.transparent),

                    shadowColor: const MaterialStatePropertyAll(Colors.transparent)
                    
                    ),
              
                onPressed: (){
            
                if(_UpdateState.page.text.isNotEmpty){
            
                if(widget.note != null){
            
                value.dbHelper.update(NotesModel(title:  _UpdateState.pageTitle.text.isNotEmpty ? _UpdateState.pageTitle.text : 'Untitled', description: _UpdateState.page.text, date: date, id: widget.note!.id));
              
                value.initDatabase();
              
                  value.setLength();
                } 
            
                else{
            
                  value.dbHelper.insert(NotesModel(title: _UpdateState.pageTitle.text.isNotEmpty ? _UpdateState.pageTitle.text : 'Untitled', description: _UpdateState.page.text, date: date));
              
                  value.initDatabase();
              
                  value.setLength();
                }
            
                Navigator.of(context).pop();
            
                }

                else{
                  SnackBarUtils.showSnackbar(context, CupertinoIcons.pencil_slash, "Please enter title and description");
                }
            
                }, 
              
              
                child: Text('Update', style: TextStyle(fontFamily: 'Inter', fontSize: 18, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.tertiary))

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
      
                  toolbar(_UpdateState.page, context),
      
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