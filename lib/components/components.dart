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

        iconSize: const MaterialStatePropertyAll(26),

        iconColor: MaterialStatePropertyAll(textColor ?? Theme.of(context).colorScheme.tertiary),

        overlayColor: MaterialStatePropertyAll(overlayColor ?? Colors.transparent),
      )
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

    style: TextStyle(color: textColor ?? Theme.of(context).colorScheme.tertiary, fontSize: 18, height: 2),

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

FilledButton tonalButton(context, {required void Function()? fn, required String text, required IconData icon, Size? size, double? textSize, double? iconSize}){

  return FilledButton.tonal(onPressed: fn,

    style: ButtonStyle(

      fixedSize: MaterialStatePropertyAll(size ?? const Size(175, 50)),

      backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),

      shadowColor: const MaterialStatePropertyAll(Colors.transparent),

      overlayColor: const MaterialStatePropertyAll(Colors.white)

    ),
    
    child: Row(

      children: [
        
        Icon(icon, size: iconSize?? 25, color: Theme.of(context).colorScheme.tertiary),
    
        const Gap(8),
        
        Text(text, style: TextStyle(fontSize: textSize ?? 18, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.tertiary)),
      ],
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
          
          side: MaterialStatePropertyAll(BorderSide(width: 1, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8))),

          padding: const MaterialStatePropertyAll(EdgeInsets.all(18)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: const MaterialStatePropertyAll(Colors.transparent)), child: Text("$words words", style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.tertiary))),
    
        const Gap(7),
    
        FilledButton(onPressed: (){}, style: ButtonStyle(
          
          side: MaterialStatePropertyAll(BorderSide(width: 1, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8))),

          padding: const MaterialStatePropertyAll(EdgeInsets.all(18)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: const MaterialStatePropertyAll(Colors.transparent)), child: Text("$char characters", style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.tertiary))),
    
        const Gap(7),
    
        FilledButton(onPressed: (){}, style: ButtonStyle(

          side: MaterialStatePropertyAll(BorderSide(width: 1, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8))),

          padding: const MaterialStatePropertyAll(EdgeInsets.all(18)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: const MaterialStatePropertyAll(Colors.transparent)), child: Text("$lines lines", style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.tertiary))),
      ],
    ),
  );
}

IconButton suffix(context){
  return IconButton(onPressed: (){
        SnackBarUtils.showSnackbar(context, Icons.window_sharp, "Press Windows + H");
      }, icon: const Icon(FluentIcons.mic_24_regular), padding: const EdgeInsets.all(1));
}

TextField titleBox(context, {required TextEditingController controller}){

  return TextField(

    controller: controller,

    decoration: InputDecoration(

      hintText: "Subject",

      hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.tertiary),

      constraints: const BoxConstraints(maxWidth: 520),

      contentPadding: const EdgeInsets.all(20),

      border: InputBorder.none,

      focusColor: Colors.transparent,

      hoverColor: Colors.transparent
    ),

    style: const TextStyle(fontSize: 26),
  );
}