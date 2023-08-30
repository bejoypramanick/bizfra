import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../widgets/screens/capture_photo_screen.dart';

class ImageHelper {
  static SizedBox buildImageBox(Uint8List? photoData) {
    return SizedBox(
        width: 100,
        height: 100,
        child: photoData != null && photoData.isNotEmpty
            ? Image.memory(photoData ?? Uint8List(0), fit: BoxFit.fill)
            : const Text("No Photo", textAlign: TextAlign.center));
  }

  static Container cameraPreviewBox(CameraController? controller) {
    return Container(
      height: 200,
      width: 200,
      padding: const EdgeInsets.all(30),
      child: controller == null
          ? const Center(child: Text("Loading Camera..."))
          : !controller!.value.isInitialized
              ? const Center(child: CircularProgressIndicator())
              : CameraPreview(controller!),
    );
  }

  static Container capturedImageBox(CameraWidget widget) {
    return Container(
      height: 200,
      width: 200,
      padding: const EdgeInsets.all(30),
      child: widget.photoData != null && widget.photoData.isNotEmpty
          ? Image.memory(widget.photoData, height: 200, width: 200)
          : const Text("No Photo", textAlign: TextAlign.center),
    );
  }
}
