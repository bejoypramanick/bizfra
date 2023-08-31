import 'dart:io';
import 'dart:typed_data';

import 'package:bizfra/widgets/container/checkbox_container_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../widgets/container/hyperlink_container_widget.dart';

class DataTableHelper {
  static DataColumn buildDataColumn(String name) {
    return DataColumn(
        label: Text(name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
  }

  static DataRow buildDataRow(String name, String? value) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text(value ?? "")),
      ],
    );
  }

  static DataRow buildDataRowForImage(String name, PlatformFile? file) {
    Uint8List? filebytes = _getBytesFromPlatformFile(file);
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Container(
            constraints: const BoxConstraints(maxWidth: 200, maxHeight: 200),
            child: filebytes != null
                ? (file?.extension?.toLowerCase() == "pdf"
                    ? PDFView(pdfData: filebytes)
                    : Image.memory(filebytes, fit: BoxFit.fill))
                : const Text("No Photo", textAlign: TextAlign.center)))
      ],
    );
  }

  static DataRow buildTermsCheckbox() {
    return const DataRow(
      cells: [
        DataCell(Align(
            alignment: Alignment.centerRight,
            child: CheckboxContainerWidget())),
        DataCell(Align(
            alignment: Alignment.centerLeft, child: HyperlinkContainerWidget()))
      ],
    );
  }

  static Uint8List? _getBytesFromPlatformFile(PlatformFile? pfile) {
    if (pfile == null) {
      return null;
    }
    if (pfile.bytes != null && pfile.bytes!.isNotEmpty) {
      return pfile.bytes;
    } else {
      //for android phone pfile.bytes is null probably for external storage
      String path = pfile?.path ?? "";
      File file = File(path);
      List<int> bytes = file.readAsBytesSync();
      if (bytes != null && bytes.isNotEmpty) {
        Uint8List byteList = Uint8List.fromList(bytes);
        return byteList;
      } else {
        return null;
      }
    }
  }
}
