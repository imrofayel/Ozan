import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:ozan/views/markdown.dart';
import 'package:ozan/components/snackbar.dart';

class FileService {
  
  FileService(this.markdown);

  TextEditingController markdown;
  
  File? _selectedFile;
  String? _selectedDirectory = '';

  Future<void> saveContent(context) async {

    final content = markdown.text;

    String? filePath;

    try {

      if (_selectedFile != null) {

        await _selectedFile!.writeAsString(content);

      } else {

        String metadataDirPath = _selectedDirectory!;

        if (metadataDirPath.isEmpty) {
          final directory = await FilePicker.platform.getDirectoryPath();
          _selectedDirectory = metadataDirPath = directory!;
        }

        filePath = '$metadataDirPath\\${title()}.md';

        final newFile = File(filePath);
        await newFile.writeAsString(content);
      }

      SnackBarUtils.showSnackbar(
          context, Icons.check, "File Saved at ${filePath ?? _selectedDirectory}");
    } catch (e) {
      SnackBarUtils.showSnackbar(context, FluentIcons.warning_24_regular, "Unexpected error occurred");
    }
  }

  void newFile(context) {
    _selectedFile = null;
    _selectedDirectory = '';
    markdown.clear();
    SnackBarUtils.showSnackbar(
        context, FluentIcons.document_page_bottom_right_24_regular, "New File Loaded, Please write something in editor to see changes!");
  }

  Future<void> loadFile(context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        _selectedFile = file;
        _selectedDirectory = file.parent.path;
        markdown.text = await file.readAsString();

        SnackBarUtils.showSnackbar(
            context, FluentIcons.checkmark_circle_24_regular, "File Uploaded, edit a single letter in editor to see changes!");
      } else {
        SnackBarUtils.showSnackbar(context, FluentIcons.warning_24_regular, "File not selected");
      }
    } catch (e) {
      SnackBarUtils.showSnackbar(context, FluentIcons.warning_24_regular, "Unexpected error occurred");
    }
  }
}