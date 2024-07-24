import 'package:markdown/markdown.dart' as md;
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Wavy extends md.InlineSyntax {
  Wavy() : super(r'#(.*?)#');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final text = match[1]!;
    final el = md.Element.text('wavy', text);
    parser.addNode(el);
    return true;
  }
}
class WavyBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    if (element.tag == 'wavy') {
      return Text(
        element.textContent,
        style: const TextStyle(decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.wavy, decorationThickness: 2),
      );
    }
    return null;
  }
}
