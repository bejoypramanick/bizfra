import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

class DocumentsModel {
  final String aadharNumber;
  final String panNumber;
  final String gstNumber;
  final PlatformFile? aadharFile;
  final PlatformFile? panFile;
  final PlatformFile? gstFile;

  DocumentsModel({
    required this.aadharNumber,
    required this.panNumber,
    required this.gstNumber,
    required this.aadharFile,
    required this.panFile,
    required this.gstFile
});
// You can add file paths for document uploads here
}
