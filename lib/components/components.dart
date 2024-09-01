// import 'package:dictionaryx/dictionary_msa.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:gap/gap.dart';
import 'package:ozan/components/snackbar.dart';

FilledButton button(void Function()? function, IconData icon, context, {required String tooltip}){

  return  FilledButton(onPressed: function, style: ButtonStyle(
          
            side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),

            padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), 
                      
            child: Row(

              children: [

                Icon(icon, size: 21, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9)),

                const Gap(8),

                Text(tooltip, textScaler: const TextScaler.linear(1.3), style: TextStyle(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9))),
              ],
      ));
}

TextField textField(context, {int? lines = 1, required void Function(String)? onSubmitted, required void Function(String)? onChanged, required TextEditingController controller, FocusNode? focusNode, required Color color, Color? textColor}){

  return TextField(

  spellCheckConfiguration: const SpellCheckConfiguration(),

    contextMenuBuilder: (context, editableTextState) {
      final TextEditingValue value = editableTextState.textEditingValue;
      final List<ContextMenuButtonItem> buttonItems =
          List.from(editableTextState.contextMenuButtonItems);

      // Check if text is selected
  if (value.selection.isValid && !value.selection.isCollapsed) {
    // Add custom menu items for bold and italic
    buttonItems.insert(
      0,
      ContextMenuButtonItem(
        label: 'Uppercase',
        onPressed: () {
          ContextMenuController.removeAny();
          // Get the selected text
          final selectedText = value.text.substring(
              value.selection.start, value.selection.end);
          // Convert to uppercase
          final uppercasedText = selectedText.toUpperCase();
          // Replace selected text with uppercase version
          controller.text = value.text.replaceRange(
              value.selection.start,
              value.selection.end,
              uppercasedText);
          // Update the selection to the end of the uppercase text
          controller.selection = TextSelection.collapsed(
              offset: value.selection.start + uppercasedText.length);
        },
      ),
    );
    buttonItems.insert(
      1,
      ContextMenuButtonItem(
        label: 'Lowercase',
        onPressed: () {
          ContextMenuController.removeAny();
          // Get the selected text
          final selectedText = value.text.substring(
              value.selection.start, value.selection.end);
          // Convert to lowercase
          final lowercasedText = selectedText.toLowerCase();
          // Replace selected text with lowercase version
          controller.text = value.text.replaceRange(
              value.selection.start,
              value.selection.end,
              lowercasedText);
          // Update the selection to the end of the lowercase text
          controller.selection = TextSelection.collapsed(
              offset: value.selection.start + lowercasedText.length);
        },
      ),
    );
  }

      // Customize the context menu appearance
      return AdaptiveTextSelectionToolbar.buttonItems(
        anchors: editableTextState.contextMenuAnchors,
        buttonItems: buttonItems,
      );    },

    cursorColor: Theme.of(context).colorScheme.tertiary,
    
    controller: controller,

    onSubmitted: onSubmitted,

    onChanged: onChanged,

    maxLines: lines,

    focusNode: focusNode,

    style: TextStyle(color: textColor ?? Theme.of(context).colorScheme.tertiary, fontSize: 17, height: 2, fontFamily: 'Inter'),

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
                                                  
        side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1))),
                                                                                  
        padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background)), child: Text('$words words', style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter'))),
    
        const Gap(9),
    
        FilledButton(onPressed: (){}, style: ButtonStyle(
                                                  
        side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1))),
                                                                                  
        padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background)), child: Text('$char characters', style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter'))),
    
        const Gap(9),
    
        FilledButton(onPressed: (){}, style: ButtonStyle(
                                                  
        side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1))),
                                                                                  
        padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background)), child: Text('$lines lines', style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.tertiary, fontFamily: 'Inter'))),
      ],
    ),
  );
}

IconButton suffix(context){
  return IconButton(onPressed: (){
        SnackBarUtils.showSnackbar(context, Icons.window_sharp, "Press Windows + H");
      }, icon: const Icon(FluentIcons.mic_24_regular), padding: const EdgeInsets.all(1));
}

String greet(String name){
  
  String text;

  if(DateTime.now().hour > 0 && DateTime.now().hour <= 11){
    text = 'Good Morning ${name.split(' ')[0]}!';
  }

  else if(DateTime.now().hour > 11 && DateTime.now().hour <= 16){
    text = 'Good Afternoon ${name.split(' ')[0]}!';
  }

  else{
    text = 'Good Evening ${name.split(' ')[0]}!';
  }

  return text;
}

// Function to generate table of contents from Markdown notes
String generateTableOfContents(String markdown) {
  final document = md.Document();
  final List<String> headings = [];

  // Parse the Markdown and collect headings
  document.parseLines(markdown.split('\n')).forEach((element) {
    if (element is md.Element && element.tag.startsWith('h') && element.tag.length == 2) {
      // Add the whole heading text without cutting off any part
      headings.add(element.textContent);
    }
  });

  // Generate the TOC Markdown string
  final buffer = StringBuffer();
  int count = 1;
  for (final heading in headings) {
    buffer.writeln('$count. $heading\n');
    count++;
  }

  return buffer.toString();
}


