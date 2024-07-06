import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:ozan/components/snackbar.dart';
import 'package:ozan/file_service/file_service.dart';
import 'package:ozan/components/components.dart';
import 'package:ozan/components/toolbar.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/db/notes.dart';
import 'package:provider/provider.dart';
import 'markdown/markdown_style.dart';

// ignore: must_be_immutable
class Markdown extends StatefulWidget {

  const Markdown({super.key});

  static FileService files = FileService(_MarkdownState.page, _MarkdownState.pageTitle);

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

      super.initState();
}

  @override
  void dispose() {
      // page.dispose(); // Dispose the TextEditingController
      // _focusNode.dispose(); // Dispose the FocusNode
      super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    String date = DateFormat('d MMM, yy').format(DateTime.now()); 

    return Consumer<DatabaseProvider>(builder:(context, value, child){

      return Scaffold(

        appBar: AppBar(

          toolbarHeight: 100,

          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(CupertinoIcons.arrow_left, size: 20, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
            
            ),
          ),

          title: Expanded(child: Container(decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.3) : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20), border: Border.all(color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100.withOpacity(0.2) : Theme.of(context).colorScheme.secondary)
          ), child: titleBox(context, controller: pageTitle))),

          centerTitle: true,

          actions: [

            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,14,0),

              child: FilledButton(onPressed: (){
                
                if(_MarkdownState.page.text.isNotEmpty){
                    
                value.dbHelper.insert(NotesModel(title: _MarkdownState.pageTitle.text.isNotEmpty ? _MarkdownState.pageTitle.text : 'Untitled', description: _MarkdownState.page.text, date: date, favourite: 0));
                      
                value.initDatabase();
                      
                value.setLength();
              
                Markdown.files.newFile(context);
                          
                Navigator.of(context).pop();
                          
                } else{
                    SnackBarUtils.showSnackbar(context, CupertinoIcons.pencil_slash, "Please enter title and description");
                }
              }, style: ButtonStyle(
                                                    
                side: MaterialStatePropertyAll(BorderSide(color:Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100.withOpacity(0.2) : Theme.of(context).colorScheme.secondary)),
                                                                                    
                padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.3) : Theme.of(context).colorScheme.primary)), child: Text('Save', style: TextStyle(fontSize: 18, color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade900 : Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter'))),
            ),
          ],
        ),
        
        body: Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
          child: Row(
          
            children: [
          
              Expanded(
          
                flex: 4,
          
                child: Row(
                
                  children: [
                
                    Expanded(
                    
                      flex: 6,
                    
                      child: SingleChildScrollView(
                       
                        scrollDirection: Axis.vertical,
                
                        child: Column(
                        
                          mainAxisAlignment: MainAxisAlignment.center,
                        
                          children: [
                                  
                            SizedBox(
                                      
                              height: 450,
                                      // change md to page.text
                              child: markdown(page.text, 1.25, context)
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
              ),

              const Gap(50),
          
              const Expanded(flex: 4, child: Editor()),
            ],
          ),
        ),
      );
    }
    );
}
}

String title(){
  
  String getTitle = 'Untitled${DateTime.now().microsecond}';

  if(_MarkdownState.pageTitle.text.isNotEmpty){
    getTitle = _MarkdownState.pageTitle.text;
  }

  return getTitle;
}


// Editor Dialogue
// ignore: must_be_immutable
class Editor extends StatefulWidget {

  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {

  @override
  Widget build(BuildContext context) {

    return Consumer<DatabaseProvider>(builder:(context, value, child){

      return SizedBox(
            
        height: 480,
            
        width: 550,
            
        child: Column(
            
          children: [
            
              Opacity(opacity: 0.8, child: toolbar(_MarkdownState.page, context)),
            
              const Gap(8),
        
                Column(
        
                  mainAxisAlignment: MainAxisAlignment.center,
            
                  crossAxisAlignment: CrossAxisAlignment.center,
        
                  children: [
        
                    Padding(
            
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
            
                      child: Container(
                      
                        height: 400,
                      
                        decoration: BoxDecoration(
                          
                          borderRadius: const BorderRadius.all(Radius.circular(16)),

                          border: Border.all(color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade100.withOpacity(0.2) : Theme.of(context).colorScheme.secondary),
                          
                          // TextBox
                          color: Theme.of(context).brightness == Brightness.light ? Colors.blue.shade50.withOpacity(0.3) : Theme.of(context).colorScheme.primary,
                        ),
                      
                        child: Padding(
                        
                          padding: const EdgeInsets.all(10),

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
      );
    }
    );
  }
}