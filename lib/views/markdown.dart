import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ozan/components/widgets.dart';
import 'package:ozan/database/file_service.dart';
import 'package:ozan/components/components.dart';
import 'package:ozan/components/toolbar.dart';
import 'package:intl/intl.dart';
import '../markdown/markdown_style.dart';
class Markdown extends StatefulWidget {

  const Markdown({super.key});

  static FileService files = FileService(_MarkdownState.page);

  @override
  State<Markdown> createState() => _MarkdownState();
}

class _MarkdownState extends State<Markdown>{

  TextEditingController prompt = TextEditingController();

  TextEditingController search = TextEditingController();

  static TextEditingController page = TextEditingController();

  static TextEditingController pageTitle = TextEditingController();

  static FocusNode _focusNode = FocusNode();// Declare the FocusNode

  String data = ''; // AI Generated response

  static String md = 'Open Editor & Capture your thoughts!'; // Markdown Box data
  
  @override
  void initState() {
      page.addListener(() => setState(() {})); 
      _focusNode = FocusNode(); // Assign a FocusNode
      super.initState();
}

  @override
  void dispose() {
      page.dispose(); // Dispose the TextEditingController
      _focusNode.dispose(); // Dispose the FocusNode
      super.dispose();
  }

  Widget date(context, TextEditingController controller){
    
    return  IconButton(onPressed: () async{

      var date = await showDatePickerDialog(context);

        setState(() {
          pageTitle.text = DateFormat('EE, d MMMM y').format(date);
        });

    }, tooltip: "Date", style: ButtonStyle(padding: const MaterialStatePropertyAll(EdgeInsets.zero), shadowColor: const MaterialStatePropertyAll(Colors.transparent), overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), icon: const Icon(FluentIcons.calendar_week_start_24_regular, size: 28));
  }

  @override
  Widget build(BuildContext context) {

    return Row(

      children: [

        Expanded(
        
          flex: 6,
        
          child: SingleChildScrollView(
           
            scrollDirection: Axis.vertical,

            child: Column(
            
              mainAxisAlignment: MainAxisAlignment.center,
            
              children: [
                
                Padding(

                  padding: const EdgeInsets.only(right: 25.0),

                  child: Row(
                    
                    children: [
                  
                      Expanded(child: titleBox(context, controller: pageTitle)),
                  
                      const Gap(10),
                  
                      // Date picker
                              
                      date(context, pageTitle),
                              
                      const Gap(15),
                              
                      IconButton(onPressed: (){
                              
                        showDialog(
                          context: context, 
                              
                          builder: (context){
                            return const Editor();
                          }
                        );
                      }, tooltip: "Editor", style: ButtonStyle(padding: const MaterialStatePropertyAll(EdgeInsets.zero), shadowColor: const MaterialStatePropertyAll(Colors.transparent), overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), icon: const Icon(FluentIcons.text_edit_style_24_regular, size: 28)),
                    ],
                  ),
                ),
                      
                SizedBox(
                          
                  height: 450,
                          
                  child: markdown(md, 1.36, context)
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
class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return SimpleDialog(

      elevation: 0,

      shadowColor: Colors.transparent,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      title: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          
          const Row(

            children: [

              Icon(FluentIcons.text_edit_style_24_regular, size: 26),
          
              Gap(10),

              Text("Writer"),
            ],
          ),

          IconButton(onPressed: (){
            Navigator.of(context).pop();
          }, icon: const Icon(FluentIcons.full_screen_minimize_24_regular, size: 26))
        ],
      ),

      titlePadding: const EdgeInsets.fromLTRB(30, 30, 20, 10),

      children: [

        SizedBox(

          height: 480,

          width: 550,

          child: Column(

            children: [

                Padding(

                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),

                  child: toolbar(_MarkdownState.page, context),
                ),

                  const Gap(14),
          
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
                            color: Theme.of(context).colorScheme.primary,
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
                                      _MarkdownState.page.text += '\n';
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
}