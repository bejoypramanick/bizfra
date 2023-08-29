

import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

class DocumentsModel {
  final String aadharNumber;
  final String panNumber;
  final String gstNumber;
  final Uint8List aadharData;
  final Uint8List panData;
  final Uint8List gstData;
  final FileType aadharFileType;
  final FileType panFileType;
  final FileType gstFileType;

  DocumentsModel(
      {required this.aadharNumber,
      required this.panNumber,
      required this.gstNumber,
      required this.aadharData,
      required this.panData,
      required this.gstData,
      required this.aadharFileType,
      required this.panFileType,
      required this.gstFileType});
// You can add file paths for document uploads here
}
