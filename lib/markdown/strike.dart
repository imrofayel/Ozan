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
      return Text(
        element.textContent,
        style: const TextStyle(decoration: TextDecoration.lineThrough, decorationStyle: TextDecorationStyle.wavy, decorationThickness: 2),
      );
    }
    return null;
  }
}
