import 'package:markdown/markdown.dart' as md;
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CHighlightSyntax extends md.InlineSyntax {
  CHighlightSyntax() : super(r'=(#[0-9a-fA-F]{6}|[a-zA-Z]+)=([^=]+)=(#[0-9a-fA-F]{6}|[a-zA-Z]+)=');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final bgColor = match[1]!;
    final text = match[2]!;
    final textColor = match[3]!;
    final el = md.Element('chighlight', [md.Text(text)]);
    el.attributes['bgColor'] = bgColor;
    el.attributes['textColor'] = textColor;
    parser.addNode(el);
    return true;
  }
}
class CHighlightBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    if (element.tag == 'chighlight') {
      final bgColorString = element.attributes['bgColor'];
      final textColorString = element.attributes['textColor'];
      final bgColor = _parseColor(bgColorString ?? '#FFFF00'); // Default to yellow if no bgColor is provided
      final textColor = _parseColor(textColorString ?? '#000000'); // Default to black if no textColor is provided

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
        ),
        child: Text(
          element.textContent,
          style: TextStyle(color: textColor),
          textScaler: const TextScaler.linear(1.25)
        ),
      );
    }
    return null;
  }

  Color _parseColor(String colorString) {
    if (colorString.startsWith('#')) {
      // Assume hex color code
      return Color(int.parse(colorString.substring(1, 7), radix: 16) + 0xFF000000);
    } else {
      // Handle named colors or invalid input here
      try {
        return Color(int.parse(colorString, radix: 16) + 0xFF000000);
      } catch (e) {
        return Colors.black; // Default color if parsing fails
      }
    }
  }
}
