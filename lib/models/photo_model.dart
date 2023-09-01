import 'dart:convert';
import 'dart:typed_data';

class PhotoModel {
  final Uint8List photoData;
  PhotoModel({required this.photoData});

  Map<String, dynamic> toJson() {
    return {
      'photoData': base64Encode(photoData), // Convert Uint8List to a base64-encoded string
    };
  }
}
