// import 'package:dictionaryx/dictionary_msa.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:ozan/components/snackbar.dart';

IconButton button(void Function()? function, IconData icon, context, {Color? textColor, Color? overlayColor, required String tooltip}){

  return IconButton(

      tooltip: tooltip,

      onPressed: function, 

      icon: Icon(icon),
    
      style: ButtonStyle(

        iconSize: const MaterialStatePropertyAll(22),

        padding: const MaterialStatePropertyAll(EdgeInsets.all(8)),

        backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),

        iconColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.tertiary.withOpacity(0.6)),

        overlayColor: const MaterialStatePropertyAll(Colors.transparent),

        side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)
      ))
  );
}

TextField textField(context, {int? lines = 1, required void Function(String)? onSubmitted, required void Function(String)? onChanged, required TextEditingController controller, FocusNode? focusNode, required Color color, Color? textColor}){

  return TextField(

    cursorColor: Theme.of(context).colorScheme.tertiary,
    
    controller: controller,

    onSubmitted: onSubmitted,

    onChanged: onChanged,

    maxLines: lines,

    focusNode: focusNode,

    style: TextStyle(color: textColor ?? Theme.of(context).colorScheme.tertiary, fontSize: 18, height: 2, fontFamily: 'Inter'),

    decoration: InputDecoration(

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

void copyToClipboard(context, String text){

      Clipboard.setData(ClipboardData(text: text));

      SnackBarUtils.showSnackbar(context, FluentIcons.copy_24_regular, "Copied to clipboard");
  }


SingleChildScrollView textEncode(context, {required int words, required int char, required int lines}){

  return SingleChildScrollView(

    scrollDirection: Axis.horizontal,

    child: Row(
      
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    
      children: [
    
        FilledButton(onPressed: (){}, style: ButtonStyle(
          
          side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),

          padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), child: Text("$words words", style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8), fontFamily: 'Inter'))),
    
        const Gap(9),
    
        FilledButton(onPressed: (){}, style: ButtonStyle(
          
          side: MaterialStatePropertyAll(BorderSide(width: 1, color: Theme.of(context).colorScheme.secondary)),

          padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), child: Text("$char characters", style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8), fontFamily: 'Inter'))),
    
        const Gap(9),
    
        FilledButton(onPressed: (){}, style: ButtonStyle(

          side: MaterialStatePropertyAll(BorderSide(width: 1, color: Theme.of(context).colorScheme.secondary)),

          padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), child: Text("$lines lines", style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8), fontFamily: 'Inter'))),
      ],
    ),
  );
}

IconButton suffix(context){
  return IconButton(onPressed: (){
        SnackBarUtils.showSnackbar(context, Icons.window_sharp, "Press Windows + H");
      }, icon: const Icon(FluentIcons.mic_24_regular), padding: const EdgeInsets.all(1));
}

Widget titleBox(context, {required TextEditingController controller}){

  return TextField(

    controller: controller,

    decoration: InputDecoration(

      hintText: "Untitled",

      hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.tertiary),

      constraints: const BoxConstraints(maxWidth: 520),

      contentPadding: const EdgeInsets.all(18),

      focusColor: Colors.transparent,

      hoverColor: Colors.transparent,

      border: InputBorder.none

    ),

    style: const TextStyle(fontSize: 24),
  );
}

String greet(String name){
  
  String text;

  if(DateTime.now().hour > 0 && DateTime.now().hour <= 11){
    text = 'Good Morning $name!';
  }

  else if(DateTime.now().hour > 11 && DateTime.now().hour <= 16){
    text = 'Good Afternoon $name!';
  }

  else{
    text = 'Good Evening $name!';
  }

  return text;
}