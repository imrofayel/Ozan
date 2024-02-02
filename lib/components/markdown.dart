import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ozan/components/file_service.dart';
import 'package:ozan/components/snackbar.dart';
import 'package:ozan/components/components.dart';
import 'package:ozan/components/toolbar.dart';
import 'package:ozan/theme/theme.dart';
import 'package:intl/intl.dart';

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

  String md = ''; // Markdown Box data
  
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

  void templates(context){

    showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          shadowColor: Colors.transparent,

          backgroundColor: Themes.accent,

          contentPadding: const EdgeInsets.all(20),

          insetPadding: EdgeInsets.zero,
          
          content: SizedBox(

            height: 120,

            child: Column(

              children: [

                Row(
                
                  children: [
                    
                    FilledButton.tonal(onPressed: (){
                      setState(() {
                        page.text += DateFormat('EEEE, d MMMM y').format(DateTime.now());
                      });
                    }, style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(80, 50)), padding: MaterialStatePropertyAll(EdgeInsets.zero), shadowColor: MaterialStatePropertyAll(Colors.transparent)), child: const Text("Date", style: TextStyle(fontSize: 16))),
                
                    const Gap(8),
                
                    FilledButton.tonal(onPressed: (){

                    }, style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(50, 50)), padding: MaterialStatePropertyAll(EdgeInsets.zero), shadowColor: MaterialStatePropertyAll(Colors.transparent)), child: const Text("H1", style: TextStyle(fontSize: 16))),
                
                    const Gap(8),
                
                    FilledButton.tonal(onPressed: (){}, style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(50, 50)), padding: MaterialStatePropertyAll(EdgeInsets.zero), shadowColor: MaterialStatePropertyAll(Colors.transparent)), child: const Text("H2", style: TextStyle(fontSize: 16))),
                
                    const Gap(8),
                
                    FilledButton.tonal(onPressed: (){}, style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(50, 50)), padding: MaterialStatePropertyAll(EdgeInsets.zero), shadowColor: MaterialStatePropertyAll(Colors.transparent)), child: const Text("H3", style: TextStyle(fontSize: 16))),
                
                    const Gap(8),
                
                    FilledButton.tonal(onPressed: (){}, style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(50, 50)), padding: MaterialStatePropertyAll(EdgeInsets.zero), shadowColor: MaterialStatePropertyAll(Colors.transparent)), child: const Text("H4", style: TextStyle(fontSize: 16))),
                  ],
                ),

                const Gap(10),

                Row(
                
                  children: [
                    
                    FilledButton.tonal(onPressed: (){
                      
                    }, style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(120, 50)), padding: MaterialStatePropertyAll(EdgeInsets.zero), shadowColor: MaterialStatePropertyAll(Colors.transparent)), child: const Text("Code Block", style: TextStyle(fontSize: 16))),
                
                    const Gap(8),
                
                    FilledButton.tonal(onPressed: (){}, style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(70, 50)), padding: MaterialStatePropertyAll(EdgeInsets.zero), shadowColor: MaterialStatePropertyAll(Colors.transparent)), child: const Text("Table", style: TextStyle(fontSize: 16))),
                
                    const Gap(8),
                
                    FilledButton.tonal(onPressed: (){}, style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(130, 50)), padding: MaterialStatePropertyAll(EdgeInsets.zero), shadowColor: MaterialStatePropertyAll(Colors.transparent)), child: const Text("Blockquote", style: TextStyle(fontSize: 16))),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
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
          
                    height: 400,
          
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
          
                          textField(context, onSubmitted: (str){
                            generate(prompt.text);
                            SnackBarUtils.showSnackbar(context, Iconsax.magic_star, "Ozan is generating. . .");
                          }, onChanged: null, controller: prompt, color: Themes.background, textColor: Themes.text.withOpacity(0.8), suffix: suffix(context)),
                        ],
                      ),
                    ),
                  ),
          
                  const Gap(15),

                  toolbar(page, context),

                  const Gap(15),
          
                  Column(
          
                    mainAxisAlignment: MainAxisAlignment.center,

                    crossAxisAlignment: CrossAxisAlignment.center,
          
                    children: [
          
                      Container(
                      
                        height: 340,
                      
                        decoration: BoxDecoration(
                          
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          
                          // TextBox
                          color: Themes.accent,
                        ),
                      
                        child: Padding(
                        
                          padding: const EdgeInsets.all(6.0),
                        
                          child: SingleChildScrollView(

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

                                        FilledButton.tonal(onPressed: ()=> templates(context), style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(120, 45)), padding: MaterialStatePropertyAll(EdgeInsets.zero), shadowColor: MaterialStatePropertyAll(Colors.transparent)), child: const Text("Templates", style: TextStyle(fontSize: 16)))
                                      ],
                                    ),
                                  ),
                            
                                  textField(context,
                                          
                                  lines: 14, 
                                          
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

                                  suffix: suffix(context)
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