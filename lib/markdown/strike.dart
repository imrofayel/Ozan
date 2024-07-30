import 'package:markdown/markdown.dart' as md;
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Strike extends md.InlineSyntax {
  Strike() : super(r'~~(.*?)~~');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final text = match[1]!;
    final el = md.Element.text('strike', text);
    parser.addNode(el);
    return true;
  }
}
class StrikeBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    if (element.tag == 'strike') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),         
        color: Colors.transparent,
),
        child: Text(
          element.textContent,
          style: TextStyle(decoration: TextDecoration.lineThrough,
          decorationStyle: TextDecorationStyle.wavy,
          decorationThickness: 2,
          decorationColor: Colors.red.shade400), textScaler: const TextScaler.linear(1.2)
        ),
      );
    }
    return null;
  }
}
