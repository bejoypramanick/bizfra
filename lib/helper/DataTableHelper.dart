import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class DataTableHelper {
  static DataColumn buildDataColumn(String name) {
    return DataColumn(
        label: Text(name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
  }

  static DataRow buildDataRow(String name, String value) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text(value)),
      ],
    );
  }

  static DataRow buildDataRowForImage(String name, PlatformFile? file) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Container(
            constraints: const BoxConstraints(maxWidth: 200, maxHeight: 200),
            child: file != null && file.bytes!.isNotEmpty
                ? (file?.extension?.toLowerCase() == "pdf"
                    ? PDFView(pdfData: file?.bytes)
                    : Image.memory(file?.bytes ?? Uint8List(0),
                        fit: BoxFit.fill))
                : const Text("No Photo", textAlign: TextAlign.center)))
      ],
    );
  }
}
