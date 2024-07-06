import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:ozan/markdown/syntax.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';

Markdown markdown(String data, double scale, context){

  return Markdown(
      
      selectable: true,
    
      data: data,
      
      softLineBreak: true,

      builders: {
        'code': CodeElementBuilder(context: context),
        'latex': LatexElementBuilder(),
      },
    
      styleSheet: MarkdownStyleSheet(

          a: const TextStyle(color: Color.fromARGB(255, 20, 53, 186), height: 1.6),

          codeblockDecoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(20), border: Border.all(color: Theme.of(context).colorScheme.secondary)),

          p: TextStyle(color: Theme.of(context).colorScheme.tertiary, height: 1.6),

          // ignore: deprecated_member_use
          textScaleFactor: scale,

          tableBorder: TableBorder.all(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.secondary, width: 1),

          tableHead: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),

          tableBody: const TextStyle(fontSize: 13),

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