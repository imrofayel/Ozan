import 'package:markdown/markdown.dart' as md;
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class HighlightSyntax extends md.InlineSyntax {
  HighlightSyntax() : super(r'==(.*?)==');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final text = match[1]!;
    final el = md.Element.text('highlight', text);
    parser.addNode(el);
    return true;
  }
}
class HighlightBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    if (element.tag == 'highlight') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),         color: Colors.yellow.shade100.withOpacity(0.6),
),
        child: SelectableText(
          element.textContent,
          style: TextStyle(color: Colors.yellow.shade900.withOpacity(0.6)), textScaler: const TextScaler.linear(1.2)
        ),
      );
    }
    return null;
  }
}
