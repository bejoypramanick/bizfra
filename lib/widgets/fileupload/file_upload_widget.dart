import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUploadWidget extends StatefulWidget {
  FileUploadWidget({super.key, required this.onUploadSuccess, this.selectedFile});

  final void Function(Uint8List? data, FileType fileType, String fileName) onUploadSuccess;
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
        widget.fileType = _determineFileType(result.files.single.name);
        if (widget.selectedFile?.bytes != null) { //chrome web
          setState(() {
            widget.onUploadSuccess(widget.selectedFile?.bytes, widget.fileType, widget.selectedFile!.name);
          });
        } else {
          widget.selectedFile = result.files.single;
          File file =  File(  widget.selectedFile!.path!);
          List<int> fileBytes = await file.readAsBytes();
          Uint8List bytes = Uint8List.fromList(fileBytes);
          setState(()   { //mobile
            widget.onUploadSuccess(bytes, widget.fileType, widget.selectedFile!.name);
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
            children: [ widget.selectedFile  != null  ? Text('File: ${widget.selectedFile?.name}') :const Text('') ]
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
