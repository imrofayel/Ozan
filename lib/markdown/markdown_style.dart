import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:ozan/markdown/syntax.dart';
import 'package:ozan/theme/theme.dart';

Markdown markdown(String data, double scale, context){

  return Markdown(
      
      selectable: true,
    
      data: data,
      
      softLineBreak: true,

      builders: {
        'code': CodeElementBuilder(context: context)
      },
    
      styleSheet: MarkdownStyleSheet(

          p: TextStyle(color: Themes.text, height: 1.6),

          textScaleFactor: scale,

          codeblockDecoration: const BoxDecoration(

            color: Colors.transparent,
          ),

          tableBorder: TableBorder.all(borderRadius: BorderRadius.circular(20), color: const Color.fromARGB(255, 244, 245, 247), width: 1.5),

          tableHead: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),

          blockquoteDecoration: BoxDecoration(
            
            color:  Themes.background.withOpacity(0.7),

            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),

          blockquotePadding: const EdgeInsets.all(20),

          blockquote: const TextStyle(fontFamily: "Times New Roman", fontSize: 16),

          horizontalRuleDecoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(width: 1, color: Themes.text.withOpacity(0.8))),

          strong: const TextStyle(fontWeight: FontWeight.w500), 

          em: const TextStyle(decoration: TextDecoration.underline, fontStyle: FontStyle.normal),
      )
    );
}
