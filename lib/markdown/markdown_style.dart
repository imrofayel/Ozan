import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:ozan/markdown/syntax.dart';

Markdown markdown(String data, double scale, context){

  return Markdown(
      
      selectable: true,
    
      data: data,
      
      softLineBreak: true,

      builders: {
        'code': CodeElementBuilder(context: context),
      },
    
      styleSheet: MarkdownStyleSheet(

          a: const TextStyle(color: Color.fromARGB(255, 20, 53, 186), height: 1.6),

          codeblockDecoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.8), borderRadius: BorderRadius.circular(20)),

          p: TextStyle(color: Theme.of(context).colorScheme.tertiary, height: 1.6),

          textScaleFactor: scale,

          tableBorder: TableBorder.all(borderRadius: BorderRadius.circular(14), color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6), width: 1),

          tableHead: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),

          blockquoteDecoration: BoxDecoration(
            
            color:  Theme.of(context).colorScheme.primary.withOpacity(0.8),

            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),

          blockquotePadding: const EdgeInsets.all(20),

          blockquote: const TextStyle(fontSize: 16),

          horizontalRuleDecoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(width: 1, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8))),

          strong: const TextStyle(fontWeight: FontWeight.w500), 

          em: const TextStyle(fontStyle: FontStyle.italic),
      )
    );
}