import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:ozan/markdown/extensions/strikethrough.dart';
import 'package:ozan/markdown/extensions/syntax_highlight.dart';
import 'package:ozan/markdown/extensions/wavy_underline.dart';
import 'package:ozan/markdown/highlighting/highlight.dart';

import 'highlighting/colored.dart';
Markdown markdown(String data, double scale, context){

  return Markdown(
      
      selectable: true,
    
      data: data,
      
      softLineBreak: true,

      onSelectionChanged: (text, selection, cause) => {},

      onTapLink:(text, href, title) => {},

      onTapText: () => {},

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
        md.StrikethroughSyntax(),
      ],
    ),
    
      styleSheet: MarkdownStyleSheet(

          a: TextStyle(color: const Color.fromRGBO(19, 69, 137, 1), height: 1.6, decoration: TextDecoration.underline, decorationColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5), decorationThickness: 2),

          codeblockDecoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(10), border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1))),

          p: TextStyle(color: Theme.of(context).colorScheme.tertiary, height: 1.6),

          h2: const TextStyle(fontSize: 17),

          h1: const TextStyle(fontSize: 20),

          h3: const TextStyle(fontSize: 16),

          del: TextStyle(color: Theme.of(context).colorScheme.tertiary, height: 1.6, decoration: TextDecoration.underline),

          textScaler: TextScaler.linear(scale),

          listBullet: const TextStyle(fontSize: 16),

          listBulletPadding: const EdgeInsets.only(right: 10),

          tableBorder: TableBorder.all(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.secondary, width: 1),

          tableHead: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),

          tableBody: const TextStyle(fontSize: 13),

          blockquoteDecoration: BoxDecoration(
            
            color:  Theme.of(context).colorScheme.background,

            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),

          blockquotePadding: const EdgeInsets.all(20),

          blockquote: const TextStyle(fontSize: 16),

          horizontalRuleDecoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(width: 1, color: Theme.of(context).colorScheme.secondary.withOpacity(0.9))),

          strong: const TextStyle(fontWeight: FontWeight.w600), 

          em: const TextStyle(fontStyle: FontStyle.italic),

      )
    );
}