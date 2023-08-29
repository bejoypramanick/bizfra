import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUploadWidget extends StatefulWidget {
  FileUploadWidget({super.key, required this.onUploadSuccess});

  final void Function(Uint8List? data, FileType fileType) onUploadSuccess;
  FileType fileType = FileType.any;

  @override
  _FileUploadWidgetState createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  List<PlatformFile> selectedFiles = [];

  Future<void> pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null) {
        selectedFiles = result.files;
        widget.fileType = _determineFileType(result.files.single.name);
        if (selectedFiles.single.bytes != null) { //chrome web
          setState(() {
            widget.onUploadSuccess(selectedFiles.single.bytes, widget.fileType);
          });
        } else {
          File file =  File(result.files.single.path!);
          List<int> fileBytes = await file.readAsBytes();
          Uint8List bytes = Uint8List.fromList(fileBytes);
          setState(()   { //mobile
            widget.onUploadSuccess(bytes, widget.fileType);
          });
        }
      }
    } catch (e) {
      print('Error picking files: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: pickFiles,
            child: Text('Select File'),
          ),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ selectedFiles != null && selectedFiles.isNotEmpty && selectedFiles.single != null? Text('File: ${selectedFiles.single.name}') :Text('') ]
          ),
        ],
      ),
    );
  }

  FileType _determineFileType(String fileName) {
    if (fileName.endsWith('.pdf')) {
      return FileType.custom;
    } else if (fileName.endsWith('.jpg') ||
        fileName.endsWith('.jpeg') ||
        fileName.endsWith('.png')) {
      return FileType.image;
    } else {
      return FileType.any;
    }
  }
}
