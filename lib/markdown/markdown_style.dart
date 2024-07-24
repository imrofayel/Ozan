import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:ozan/markdown/colors/colored.dart';
import 'package:ozan/markdown/colors/highlight.dart';
import 'package:ozan/markdown/strike.dart';

import 'package:ozan/markdown/syntax.dart';
import 'package:ozan/markdown/wavy.dart';
Markdown markdown(String data, double scale, context){

  return Markdown(
      
      selectable: true,
    
      data: data,
      
      softLineBreak: true,

      builders: {
        'code': CodeElementBuilder(context: context),

        'highlight': HighlightBuilder(),

        'chighlight': CHighlightBuilder(),

        'wavy' : WavyBuilder(),

        'strike' : StrikeBuilder(),

        'latex': LatexElementBuilder(
          textStyle: const TextStyle(
          // color: Colors.blue,
          fontWeight: FontWeight.w100,
          ),
          textScaleFactor: 1.4,
        ),
      },

    extensionSet: md.ExtensionSet(
      [
        LatexBlockSyntax(),
        const md.FencedCodeBlockSyntax(),
        const md.AlertBlockSyntax(),
      ],
      [
        LatexInlineSyntax(),
        md.InlineHtmlSyntax(),
        HighlightSyntax(),
        CHighlightSyntax(),
        Wavy(),
        Strike(),
        md.EmojiSyntax(),
        md.AutolinkExtensionSyntax(),
        md.EmailAutolinkSyntax(),
        md.StrikethroughSyntax(),
      ],
    ),
    
      styleSheet: MarkdownStyleSheet(

          a: const TextStyle(color: Color.fromARGB(255, 20, 53, 186), height: 1.6),

          codeblockDecoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.9), borderRadius: BorderRadius.circular(10), border: Border.all(color: Theme.of(context).colorScheme.secondary)),

          p: TextStyle(color: Theme.of(context).colorScheme.tertiary, height: 1.6),

          h2: const TextStyle(fontSize: 17),

          h1: const TextStyle(fontSize: 20),

          h3: const TextStyle(fontSize: 16),

          del: TextStyle(color: Theme.of(context).colorScheme.tertiary, height: 1.6, decoration: TextDecoration.underline),

          textScaler: TextScaler.linear(scale),

          tableBorder: TableBorder.all(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.secondary, width: 1),

          tableHead: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),

          tableBody: const TextStyle(fontSize: 13),

          blockquoteDecoration: BoxDecoration(
            
            color:  Theme.of(context).colorScheme.primary.withOpacity(0.9),

            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),

          blockquotePadding: const EdgeInsets.all(20),

          blockquote: const TextStyle(fontSize: 16),

          horizontalRuleDecoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(width: 1, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.9))),

          strong: const TextStyle(fontWeight: FontWeight.w600), 

          em: const TextStyle(fontStyle: FontStyle.italic),

      )
    );
}