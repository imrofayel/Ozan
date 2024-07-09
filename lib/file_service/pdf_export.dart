import 'package:flutter/cupertino.dart';
import 'package:ozan/db/notes.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ozan/components/snackbar.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class PdfExport {
  static final fontData = File('assets/RobotoMono.ttf').readAsBytesSync();
  static final customFont = pw.Font.ttf(fontData.buffer.asByteData());

  static final textfontData = File('assets/Inter.ttf').readAsBytesSync();
  static final textcustomFont = pw.Font.ttf(textfontData.buffer.asByteData());

  static Future generateAndSavePDF(context, NotesModel note) async {
    final pdf = pw.Document();

    final List<pw.Widget> contentWidgets = [
      pw.Text(note.title,
          style: pw.TextStyle(fontSize: 20, font: textcustomFont)),

      pw.SizedBox(height: 15),

      pw.Text('Date: ${note.date}', style: pw.TextStyle(fontSize: 12, font: textcustomFont)),

      pw.SizedBox(height: 10),

      pw.Text('Tag: ${note.tag}', style: pw.TextStyle(fontSize: 12, font: textcustomFont)),

      pw.SizedBox(height: 20),

      ...parseMarkdown(note.description),
    ];

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(30),
        build: (pw.Context context) {
          return contentWidgets;
        },
      
      header: (context) {
        return pw.Column(children: [
          
          pw.Row(

            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,

            children: [
              pw.Text(note.title, style: pw.TextStyle(fontSize: 12, font: textcustomFont, color: PdfColors.blueGrey900)),

              pw.Text('Ozan', style: pw.TextStyle(fontSize: 12, font: textcustomFont, color: PdfColors.blueGrey900)),

            ]
          ),

          pw.SizedBox(height: 10)
        ]);
      },
      ),
    );

    final bytes = await pdf.save();
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select file location:',
      fileName: '${note.title}.pdf',
    );

    if (outputFile == null) {
      SnackBarUtils.showSnackbar(context, Iconsax.tick_circle, 'PDF Export failed');
      return;
    }

    final file = File(outputFile);
    await file.writeAsBytes(bytes);

    SnackBarUtils.showSnackbar(context, Iconsax.tick_circle, 'PDF Exported Successfully at $outputFile');
  }

  static List<pw.Widget> parseMarkdown(String markdown) {
    List<pw.Widget> widgets = [];
    List<String> lines = markdown.split('\n');
    bool inCodeBlock = false;
    bool inTable = false;
    bool inQuote = false;
    String codeBlockContent = '';
    String codeBlockLang = '';
    List<List<String>> tableData = [];
    String quoteContent = '';

    for (String line in lines) {
      if (line.trim().startsWith('```')) {
        if (inCodeBlock) {
          widgets.add(renderCodeBlock(codeBlockContent, codeBlockLang, customFont));
          codeBlockContent = '';
          codeBlockLang = '';
          inCodeBlock = false;
        } else {
          inCodeBlock = true;
          codeBlockLang = line.trim().substring(3).trim();
        }
        continue;
      }

      if (inCodeBlock) {
        codeBlockContent += '$line\n';
        continue;
      }

      if (line.trim().startsWith('|') && line.trim().endsWith('|')) {
        if (!inTable) {
          inTable = true;
          tableData = [];
        }
        tableData.add(line.split('|').map((cell) => cell.trim()).toList());
        continue;
      } else if (inTable) {
        widgets.add(renderTable(tableData));
        inTable = false;
        tableData = [];
      }

      if (line.trim().startsWith('>')) {
        if (!inQuote) {
          inQuote = true;
          quoteContent = '';
        }
        quoteContent += '${line.substring(line.indexOf('>') + 1).trim()}\n';
        continue;
      } else if (inQuote) {
        widgets.add(renderQuote(quoteContent.trim()));
        inQuote = false;
        quoteContent = '';
      }

      if (line.trim().startsWith('-') || line.trim().startsWith('*')) {
        widgets.add(renderBulletPoint(line));
      } else if (line.trim().startsWith('#')) {
        widgets.add(renderHeader(line));
      } else {
        widgets.add(renderParagraph(line));
      }
    }

    if (inCodeBlock) {
      widgets.add(renderCodeBlock(codeBlockContent, codeBlockLang, customFont));
    }

    if (inTable) {
      widgets.add(renderTable(tableData));
    }

    if (inQuote) {
      widgets.add(renderQuote(quoteContent.trim()));
    }

    return widgets;
  }

  static pw.Widget renderHeader(String line) {
    int level = line.indexOf(' ');
    String text = line.substring(level + 1);
    double fontSize = 20 - (level * 3);
    return pw.Column(children: [
      pw.SizedBox(height: 6),
      pw.Text(
        text,
        style: pw.TextStyle(fontSize: fontSize, font: textcustomFont, color: PdfColors.blueGrey900),
      ),
      pw.SizedBox(height: 6),
    ]);
  }

  static pw.Widget renderParagraph(String line) {
    return pw.Column(
      children: [
        pw.SizedBox(height: 4),
        pw.RichText(
          text: pw.TextSpan(
            children: parseParagraph(line),
            style: pw.TextStyle(lineSpacing: 5, fontSize: 12, font: textcustomFont, color: PdfColors.blueGrey900)
          )
        ),
        pw.SizedBox(height: 4),
      ]
    );
  }

  static List<pw.TextSpan> parseParagraph(String text) {
    List<pw.TextSpan> spans = [];
    RegExp exp = RegExp(r'\*\*(.+?)\*\*|\*(.+?)\*|\[(.+?)\]\((.+?)\)');
    int lastMatch = 0;

    for (Match match in exp.allMatches(text)) {
      if (match.start > lastMatch) {
        spans.add(pw.TextSpan(text: text.substring(lastMatch, match.start)));
      }

      String? strongText = match.group(1);
      String? emText = match.group(2);
      String? linkText = match.group(3);
      String? linkUrl = match.group(4);

      if (strongText != null) {
        spans.add(pw.TextSpan(
          text: strongText,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: textcustomFont, fontSize: 12, color: PdfColors.blueGrey900),
        ));
      } else if (emText != null) {
        spans.add(pw.TextSpan(
          text: emText,
          style: pw.TextStyle(fontStyle: pw.FontStyle.italic, font: textcustomFont, fontSize: 12, color: PdfColors.blueGrey900),
        ));
      } else if (linkText != null && linkUrl != null) {
        spans.add(renderLink(linkText, linkUrl));
      }

      lastMatch = match.end;
    }

    if (lastMatch < text.length) {
      spans.add(pw.TextSpan(text: text.substring(lastMatch)));
    }

    return spans;
  }

  static pw.TextSpan renderLink(String text, String url) {
    return pw.TextSpan(
      text: text,
      style: pw.TextStyle(
        color: PdfColors.blue,
        decoration: pw.TextDecoration.underline,
        font: textcustomFont,
        fontSize: 12,
      ),
      annotation: pw.AnnotationUrl(url),
    );
  }

  static pw.Widget renderQuote(String text) {
    return pw.Container(
      margin: const pw.EdgeInsets.symmetric(vertical: 10),
      padding: const pw.EdgeInsets.all(10),
      decoration: const pw.BoxDecoration(
        border: pw.Border(left: pw.BorderSide(color: PdfColors.grey, width: 4)),
        color: PdfColors.grey200,
      ),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontStyle: pw.FontStyle.italic,
          color: PdfColors.blueGrey900,
          font: textcustomFont,
          fontSize: 12,
        ),
      ),
    );
  }

  static pw.Widget renderCodeBlock(String code, String lang, pw.Font customFont) {
    String languageLabel = lang.isNotEmpty ? lang : 'txt';

    return pw.Container(
      decoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(6),
        color: PdfColor.fromHex('fbfbfd'),
        border: pw.Border.all(color: PdfColors.blueGrey50)
      ),
      margin: const pw.EdgeInsets.fromLTRB(0, 6, 0, 6),
      padding: const pw.EdgeInsets.all(10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                languageLabel,
                style: pw.TextStyle(
                  fontSize: 13,
                  font: textcustomFont,
                  color: PdfColors.blueGrey900
              )),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            code,
            style: pw.TextStyle(
              font: customFont,
              fontSize: 13,
              color: PdfColors.blueGrey900
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget renderBulletPoint(String line) {
    String text = line.trim().substring(1).trim();
    return pw.Padding(
      padding: const pw.EdgeInsets.only(left: 20, bottom: 5),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('•', style: pw.TextStyle(fontSize: 14, font: textcustomFont, color: PdfColors.blueGrey100)),
          pw.SizedBox(width: 7),
          pw.Expanded(
            child: pw.Text(text, style: pw.TextStyle(fontSize: 12, font: textcustomFont, color: PdfColors.blueGrey900)),
          ),
        ],
      ),
    );
  }

static pw.Widget renderTable(List<List<String>> tableData) {
  // Remove the markdown separator row (usually the second row)
  tableData.removeWhere((row) => row.every((cell) => cell.trim().startsWith('-')));

  // Remove empty columns at the start and end
  tableData = tableData.map((row) {
    while (row.isNotEmpty && row.first.trim().isEmpty) {
      row.removeAt(0);
    }
    while (row.isNotEmpty && row.last.trim().isEmpty) {
      row.removeLast();
    }
    return row;
  }).toList();

  return pw.Container(
    child: pw.Table(
      border: pw.TableBorder.symmetric(
        inside: const pw.BorderSide(color: PdfColors.white),
      ),
      children: tableData.asMap().entries.map((entry) {
        int idx = entry.key;
        List<String> row = entry.value;
        bool isHeader = idx == 0;

        return pw.TableRow(
          decoration: isHeader
              ? pw.BoxDecoration(color: PdfColor.fromHex('fbfbfd'), border: pw.Border.all(color: PdfColors.white))
              : pw.BoxDecoration(border: pw.Border.all(color: PdfColors.white)),
          children: row.map((cell) {
            return pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(
                cell,
                style: pw.TextStyle(
                  fontSize: isHeader ? 14 : 12,
                  fontWeight: pw.FontWeight.normal,
                  font: textcustomFont,
                  color: PdfColors.blueGrey900,
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    ),
  );
}
}