import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ozan/components/widgets.dart';
import 'package:ozan/database/file_service.dart';
import 'package:ozan/components/snackbar.dart';
import 'package:ozan/components/components.dart';
import 'package:ozan/components/toolbar.dart';
import 'package:ozan/theme/theme.dart';
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

  FocusNode _focusNode = FocusNode();// Declare the FocusNode

  String data = ''; // AI Generated response

  static String md = ''; // Markdown Box data
  
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
    
    return  FilledButton.tonal(onPressed: () async{

      var date = await showDatePickerDialog(context);

        setState(() {
          pageTitle.text = DateFormat('EE, d MMMM y').format(date);
        });
    }, style: ButtonStyle(fixedSize: const MaterialStatePropertyAll(Size(60, 60)), padding: const MaterialStatePropertyAll(EdgeInsets.zero), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Themes.accent), overlayColor: MaterialStatePropertyAll(Colors.grey.shade100)), child: const Icon(Iconsax.calendar_2, size: 26));
  }

  @override
  Widget build(BuildContext context) {

    return Row(

      children: [

        Expanded(
        
          flex: 6,
        
          child: SingleChildScrollView(
           
            scrollDirection: Axis.vertical,

            child: Padding(
                      
              padding: const EdgeInsets.fromLTRB(8, 10, 10, 0),
            
              child: Column(
              
                mainAxisAlignment: MainAxisAlignment.center,
              
                children: [
                  
                  Row(
                    
                    children: [
                  
                      Expanded(child: titleBox(controller: pageTitle)),
                  
                      const Gap(10),
                  
                      // Date picker
                      date(context, pageTitle),
                    ],
                  ),
            
                  const Gap(15),
            
                  Container(
                            
                    height: 450,
                            
                    decoration: BoxDecoration(
                      
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                            
                      // Markdown BOX
                      color: Themes.accent,
                  
                      ),
                            
                    child: Padding(padding: const EdgeInsets.all(12),
                            
                      child: markdown(md, 1.30, context)
                    )
                  ),
            
                    const Gap(20),
            
                    Padding(
            
                      padding: const EdgeInsets.fromLTRB(0,0,0,15),
                      
                      child: Row(
                                        
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      
                      children: [
                                        
                        textEncode(words: page.text.split(' ').length-1, char: page.text.length, lines: page.text.split('\n').length-1),
                      
                        Row(
                        
                          children: [
                        
                            button(() => searchView(context, search, page), Iconsax.search_normal_1, context, textColor: const Color.fromARGB(255, 4, 2, 16), tooltip: "Search"),
                        
                            const Gap(10),
                        
                            tonalButton(fn: () => dictionaryView(context), text: "Dictionary", icon: Iconsax.shield_search),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Expanded(

          flex: 4,

          child: SingleChildScrollView(
          
            scrollDirection: Axis.vertical,
          
            child: Padding(
          
              padding: const EdgeInsets.all(20.0),
            
              child: Column(
              
                mainAxisAlignment: MainAxisAlignment.center,
              
                children: [
              
                  Container(
          
                    height: 360,
          
                    decoration: BoxDecoration(
                      
                      borderRadius: const BorderRadius.all(Radius.circular(20)),

                      // AI BOX
                      color: Themes.accent,
                      ),
          
                    child: Padding(
          
                      padding: const EdgeInsets.all(12.0),
          
                      child: Column(
                      
                        mainAxisAlignment: MainAxisAlignment.start,
                      
                        children: [
                          // AI Box Top Icons
                          SingleChildScrollView(
          
                            scrollDirection: Axis.vertical,
          
                            child: Row(
          
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            
                              children: [

                                Text(" Ozan Copilot", style: TextStyle(fontSize: 22, color: Themes.text)),

                                button(() => copyToClipboard(context, data), Iconsax.copy, context, tooltip: "Copy"),   
                              ],
                            ),
                          ),
          
                          Expanded(
          
                            child: markdown(data, 1.2, context),
          
                          ),
          
                          const Gap(10),
          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              
                              Expanded(

                                child: textField(context, onSubmitted: (str){
                                  generate(prompt.text);
                                  SnackBarUtils.showSnackbar(context, Iconsax.magic_star, "Ozan is generating. . .");
                                }, onChanged: null, controller: prompt, color: Themes.background, textColor: Themes.text.withOpacity(0.8)),
                              ),

                              const Gap(10),

                              IconButton(onPressed: (){}, icon: const Icon(Iconsax.voice_cricle))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
          
                  const Gap(15),

                  SingleChildScrollView(

                    scrollDirection: Axis.horizontal,

                    child: toolbar(page, context)
                  ),

                  const Gap(15),
          
                  Column(
          
                    mainAxisAlignment: MainAxisAlignment.center,

                    crossAxisAlignment: CrossAxisAlignment.center,
          
                    children: [
          
                      Container(
                      
                        height: 380,
                      
                        decoration: BoxDecoration(
                          
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          
                          // TextBox
                          color: Themes.accent,
                        ),
                      
                        child: Padding(
                        
                          padding: const EdgeInsets.all(6.0),
                          // SCSV
                          child: Column(
                            
                            mainAxisAlignment: MainAxisAlignment.start,
                          
                            crossAxisAlignment: CrossAxisAlignment.start,
                          
                            children: [ 
                              
                                Padding(
                          
                                  padding: const EdgeInsets.all(14.0),
                          
                                  child: Row(
                                  
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  
                                    children: [
                                      
                                      Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Icon(Iconsax.edit_2, size: 23),
                          
                                        const Gap(10),
                          
                                        Text("  Writer", style: TextStyle(fontSize: 22, color: Themes.text)),
                                      ]),
                                    ],
                                  ),
                                ),
                          
                                SingleChildScrollView(

                                  scrollDirection: Axis.vertical,

                                  child: textField(context,
                                          
                                  lines: 7, 
                                          
                                  onSubmitted: (text) {
                                    page.text += '\n';
                                  },
                                  
                                  onChanged: (text) {
                                    setState(() {
                                      md = text;
                                    });
                                  }, 
                                  
                                  controller: page, 
                                  
                                  focusNode: _focusNode,
                                                                
                                  color: Themes.accent,
                                  ),
                                ),
                            ]
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ),
        )
      ],
    );
}

generate(String prompt){
      
      final gemini = GoogleGemini(
        apiKey: "AIzaSyDS08hZlaB5hJfRUi8SyyX9iOZ9Z69uadY",
      );
        
      gemini.generateFromText(prompt).then((value) {

        setState(() {
          data = value.text;
        });

      }).catchError((e){  
        setState(() {
          data = '''## You're not connected!

- Check your network and try to reconnect.

- Try again later!''';

          SnackBarUtils.showSnackbar(context, Iconsax.emoji_sad, "Something went wrong!");
        });
      });
  }
}

String title(){
  
  String getTitle = 'Untitled';

  if(_MarkdownState.pageTitle.text.isNotEmpty){
    getTitle = _MarkdownState.pageTitle.text;
  }

  return getTitle;
}