import 'package:ozan/db/notes.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ozan/components/snackbar.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:file_picker/file_picker.dart';

import 'dart:io';

class PdfExport{

    static Future<void> generateAndSavePDF(context, NotesModel note) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(note.title, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text(note.description),
              pw.SizedBox(height: 20),
              pw.Text('Date: ${note.date}'),
              pw.SizedBox(height: 10),
              pw.Text('Tag: ${note.tag}'),
            ],
          );
        },
      ),
    );

    final bytes = await pdf.save();

    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
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

}