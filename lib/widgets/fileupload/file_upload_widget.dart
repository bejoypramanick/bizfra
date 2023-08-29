import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUploadWidget extends StatefulWidget {
  FileUploadWidget({super.key, required this.onUploadSuccess, this.selectedFile});

  final void Function(PlatformFile file) onUploadSuccess;
  FileType fileType = FileType.any;
  PlatformFile? selectedFile;
  @override
  _FileUploadWidgetState createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {


  Future<void> pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null) {
        widget.selectedFile = result.files.single;
        widget.onUploadSuccess(result.files.single);
        setState(() {

        });
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
            children: [ Text('File: ${widget.selectedFile?.name ?? ''}') ]
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
