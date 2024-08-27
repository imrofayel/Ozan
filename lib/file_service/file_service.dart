// ignore_for_file: unused_field

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:ozan/components/snackbar.dart';
import '../home_window.dart';

class FileService {
  
  FileService(this.markdown, this.$title);

  TextEditingController markdown;

  TextEditingController $title;
  
  File? _selectedFile;
  String? _selectedDirectory = '';

Future<void> saveContent(context) async {
  final content = markdown.text;

  try {
    String? filePath;

    final String? directoryPath = await FilePicker.platform.getDirectoryPath();

    if (directoryPath != null) {
      final fileName = $title.text.isNotEmpty ? $title.text : title();
      filePath = '$directoryPath\\$fileName.md';
    } else {
      // User canceled the save operation
      return;
    }

    final newFile = File(filePath);
    await newFile.writeAsString(content);

    SnackBarUtils.showSnackbar(
      context,
      Icons.check,
      "File Saved at $filePath",
    );
  } catch (e) {
    SnackBarUtils.showSnackbar(
      context,
      FluentIcons.warning_24_regular,
      "Unexpected error occurred",
    );
  }
}

  // Future<void> saveContent(context) async {

  //   final content = markdown.text;

  //   String? filePath;

  //   try {

  //     if (_selectedFile != null) {

  //       await _selectedFile!.writeAsString(content);

  //     } else {

  //       String metadataDirPath = _selectedDirectory!;

  //       if (metadataDirPath.isEmpty) {
  //         final directory = await FilePicker.platform.getDirectoryPath();
  //         _selectedDirectory = metadataDirPath = directory!;
  //       }

  //       filePath = '$metadataDirPath\\${$title.text.isNotEmpty ? $title.text : title()}.md';

  //       final newFile = File(filePath);
  //       await newFile.writeAsString(content);
  //     }

  //     SnackBarUtils.showSnackbar(
  //         context, Icons.check, "File Saved at ${filePath ?? _selectedDirectory}");
  //   } catch (e) {
  //     SnackBarUtils.showSnackbar(context, FluentIcons.warning_24_regular, "Unexpected error occurred");
  //   }
  // }

  void newFile(context) {
    _selectedFile = null;
    _selectedDirectory = '';
    markdown.clear();
    $title.clear();
    SnackBarUtils.showSnackbar(
        context, FluentIcons.document_page_bottom_right_24_regular, "New File Loaded!");
  }

  Future<String> loadFile(context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any, allowedExtensions: ['md', 'txt', 'text']);

      if (result != null) {
        File file = File(result.files.single.path!);
        _selectedFile = file;
        _selectedDirectory = file.parent.path;

        SnackBarUtils.showSnackbar(
            context, FluentIcons.checkmark_circle_24_regular, "File Uploaded!");
        
        return await file.readAsString();

      } else {
        SnackBarUtils.showSnackbar(context, FluentIcons.warning_24_regular, "File not selected");
      }
    } catch (e) {
      SnackBarUtils.showSnackbar(context, FluentIcons.warning_24_regular, "Unexpected error occurred");
    }

    return '';

  }
}