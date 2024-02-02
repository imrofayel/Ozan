import 'package:dictionaryx/dictionary_msa.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ozan/components/snackbar.dart';
import 'package:ozan/components/syntax.dart';
import 'package:ozan/theme/theme.dart';

IconButton button(void Function()? function, IconData icon, context, {Color? color, Color? textColor, Color? overlayColor}){

  return IconButton(

      onPressed: function, 

      icon: Icon(icon),
    
      style: ButtonStyle(

        backgroundColor: MaterialStatePropertyAll(color ?? Themes.accent),

        fixedSize: const MaterialStatePropertyAll(Size(50, 50)),

        iconSize: const MaterialStatePropertyAll(25),

        iconColor: MaterialStatePropertyAll(textColor ?? Themes.text),

        overlayColor: MaterialStatePropertyAll(overlayColor ?? Colors.white),
      )
  );
}

TextField textField(context, {int? lines = 1, required void Function(String)? onSubmitted, required void Function(String)? onChanged, required TextEditingController controller, FocusNode? focusNode, required Color color, Color? textColor, Widget? suffix}){

  return TextField(
    
    controller: controller,

    onSubmitted: onSubmitted,

    onChanged: onChanged,

    maxLines: lines,

    focusNode: focusNode,

    style: TextStyle(color: textColor ?? Themes.text, fontSize: 18),

    decoration: InputDecoration(

      suffix: suffix,

      filled: true,

      fillColor: color,

      hoverColor: Colors.transparent,
      
      enabledBorder: OutlineInputBorder(

        borderRadius: BorderRadius.circular(20),

        borderSide: const BorderSide(color: Colors.transparent),
      ),

      focusedBorder: OutlineInputBorder(

        borderRadius: BorderRadius.circular(20),
        
        borderSide: const BorderSide(color: Colors.transparent),
      ),
    ),
  );
}

Markdown markdown(String data, double scale, context){

  return Markdown(
      
      selectable: true,
    
      data: data,
      
      softLineBreak: true,

      builders: {
        'code': CodeElementBuilder(context: context)
      },
    
      styleSheet: MarkdownStyleSheet(

          p: TextStyle(color: Themes.text.withOpacity(0.9), height: 1.8),

          textScaleFactor: scale,

          codeblockPadding: const EdgeInsets.all(12),

          codeblockDecoration: const BoxDecoration(

            color:  Color.fromRGBO(248, 249, 251, 1),

            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),

          tableBorder: TableBorder.all(borderRadius: BorderRadius.circular(20), color: const Color.fromARGB(255, 244, 245, 247), width: 1.5),

          tableHead: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),

          blockquoteDecoration: const BoxDecoration(
            
            color:  Color.fromRGBO(248, 249, 251, 1),

            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),

          blockquotePadding: const EdgeInsets.all(20),

          blockquote: const TextStyle(fontFamily: "Playfair Display", fontSize: 16),

          horizontalRuleDecoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(width: 1, color: Themes.text.withOpacity(0.8))),

          strong: const TextStyle(fontWeight: FontWeight.w500), 

          em: const TextStyle(decoration: TextDecoration.underline, fontStyle: FontStyle.normal),
      )
    );
}

FilledButton tonalButton({required void Function()? fn, required String text, required IconData icon}){

  return FilledButton.tonal(onPressed: fn,

    style: ButtonStyle(

      fixedSize: const MaterialStatePropertyAll(Size(175, 50)),

      backgroundColor: MaterialStatePropertyAll(Themes.accent),

      shadowColor: const MaterialStatePropertyAll(Colors.transparent),

      overlayColor: const MaterialStatePropertyAll(Colors.white)

    ),
    
    child: Row(

      children: [
        
        Icon(icon, size: 25, color: Themes.text),
    
        const Gap(8),
        
        Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Themes.text)),
      ],
    ),
  );
}


void dictionaryView(context){

  showDialog(

    context: context,

    builder: (context) {

      return AlertDialog(

        shadowColor: Colors.transparent,

        backgroundColor: Themes.accent,

        contentPadding: const EdgeInsets.all(8),

        insetPadding: EdgeInsets.zero,
        
        content: SizedBox(

          height: 120,

          child: Column(
          
            children: [
          
              TextField(
              
                onSubmitted: (value){
                  dictionary(context, value);
                },     
                
                decoration: InputDecoration(
                  
                  prefixIcon: Icon(Iconsax.search_normal_1, color: Themes.text, size: 26),
                     
                  border: InputBorder.none,
              
                  fillColor: Themes.accent,
              
                  focusColor: Themes.accent,
              
                  hoverColor: Themes.accent,
                ),
              
                style: const TextStyle(fontSize: 19),
              ),

              const Gap(10),

              FilledButton.tonal(onPressed: (){}, style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(340, 50)), padding: MaterialStatePropertyAll(EdgeInsets.zero), shadowColor: MaterialStatePropertyAll(Colors.transparent)), child: const Text("Dictionary may take some time to load once!"))
            ],
          ),
        ),
      );
    }
  );
}

void searchView(context, TextEditingController search, TextEditingController text){

  showDialog(

    context: context,

    builder: (context) {

      return AlertDialog(

        shadowColor: Colors.transparent,

        backgroundColor: Themes.accent,

        contentPadding: const EdgeInsets.all(8),

        insetPadding: EdgeInsets.zero,
        
        content: TextField(
        
          onSubmitted: (value){
            
            if(text.text.toLowerCase().contains(value.toLowerCase())){
          
                SnackBarUtils.showSnackbar(context, Iconsax.tick_circle, "Found");
            }
            else{
                SnackBarUtils.showSnackbar(context, Iconsax.warning_2, "Not Found");
            }
          },     
          
          decoration: InputDecoration(
            
            prefixIcon: Icon(Iconsax.search_normal_1, color: Themes.text, size: 26),
       
            border: InputBorder.none,
        
            fillColor: Themes.accent,
        
            focusColor: Themes.accent,
        
            hoverColor: Themes.accent,
          ),

          style: const TextStyle(fontSize: 19),
        ),
      );
    }
  );
}

void copyToClipboard(context, String text){

      Clipboard.setData(ClipboardData(text: text));

      SnackBarUtils.showSnackbar(context, Iconsax.copy_success, "Copied to clipboard");
  }

void dictionary(BuildContext context, String word) {

  String get;

  try {

    var dMSA = DictionaryMSA();

    var entry = dMSA.getEntry(word);

    get = "(${entry.meanings.first.pos.toString().split('.')[1].toLowerCase()}) ${entry.meanings.first.description}.\nSynonyms: ${entry.synonyms.toSet()}\ne.g., ${entry.meanings.first.examples.first}";

    SnackBarUtils.showDictionarySnackbar(context, Iconsax.eye, get);

  } catch (e) {

    get = "Check your spelling or try another word";
    SnackBarUtils.showDictionarySnackbar(context, Iconsax.eye_slash, get);
  }
}


SingleChildScrollView textEncode({required int words, required int char, required int lines}){

  return SingleChildScrollView(

    scrollDirection: Axis.horizontal,

    child: Row(
      
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    
      children: [
    
        FilledButton.tonal(onPressed: (){}, style: ButtonStyle(padding: const MaterialStatePropertyAll(EdgeInsets.all(18)), overlayColor: MaterialStatePropertyAll(Themes.accent), shadowColor: const MaterialStatePropertyAll(Colors.transparent)), child: Text("$words words", style: const TextStyle(fontSize: 15))),
    
        const Gap(7),
    
        FilledButton.tonal(onPressed: (){}, style: ButtonStyle(padding: const MaterialStatePropertyAll(EdgeInsets.all(18)), overlayColor: MaterialStatePropertyAll(Themes.accent), shadowColor: const MaterialStatePropertyAll(Colors.transparent)), child: Text("$char characters", style: const TextStyle(fontSize: 15))),
    
        const Gap(7),
    
        FilledButton.tonal(onPressed: (){}, style: ButtonStyle(padding: const MaterialStatePropertyAll(EdgeInsets.all(18)), overlayColor: MaterialStatePropertyAll(Themes.accent), shadowColor: const MaterialStatePropertyAll(Colors.transparent)), child: Text("$lines lines", style: const TextStyle(fontSize: 15))),
      ],
    ),
  );
}

IconButton suffix(context){
  return IconButton(onPressed: (){
        SnackBarUtils.showSnackbar(context, Icons.window_sharp, "Press Windows + H");
      }, icon: const Icon(Iconsax.microphone), padding: const EdgeInsets.all(1));
}

TextEditingController menu = TextEditingController();

DropdownMenu categories(){

  List<DropdownMenuEntry> categories = [

    const DropdownMenuEntry(value: 0, label: "  Other"),

    const DropdownMenuEntry(value: 1, label: "  Dairy"),

    const DropdownMenuEntry(value: 2, label: "  Studies"),

    const DropdownMenuEntry(value: 3, label: "  Office"),
  ];

  return DropdownMenu(

    textStyle: const TextStyle(fontSize: 17),

    controller: menu,

    initialSelection: categories[0],

    menuStyle: MenuStyle(

      backgroundColor: MaterialStatePropertyAll(Themes.accent),

      shadowColor: const MaterialStatePropertyAll(Colors.transparent),

      elevation: const MaterialStatePropertyAll(0),
    ),

    inputDecorationTheme: InputDecorationTheme(

      fillColor: Themes.accent,

      filled: true,

      border: InputBorder.none,

      enabledBorder: OutlineInputBorder(

        borderRadius: BorderRadius.circular(20),

        borderSide: BorderSide.none
      ),

      focusedBorder: OutlineInputBorder(

        borderRadius: BorderRadius.circular(30),

        borderSide: BorderSide.none
      )

    ),

    dropdownMenuEntries: categories
  );
}

TextField titleBox({required TextEditingController controller}){

  return TextField(

    controller: controller,

    decoration: InputDecoration(

      hintText: "enter title",

      hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Themes.text.withOpacity(0.3)),

      constraints: const BoxConstraints(maxHeight: 70, maxWidth: 520),

      enabledBorder: OutlineInputBorder(

        borderRadius: BorderRadius.circular(20),

        borderSide: const BorderSide(color: Colors.transparent),
      ),

      focusedBorder: OutlineInputBorder(

        borderRadius: BorderRadius.circular(30),
        
        borderSide: const BorderSide(color: Colors.transparent),
      ),

      contentPadding: const EdgeInsets.all(20),

      border: InputBorder.none,

      filled: true,

      fillColor: Themes.accent,

      focusColor: Themes.accent,
    ),

    style: const TextStyle(fontSize: 20),
  );
}