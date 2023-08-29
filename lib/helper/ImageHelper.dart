import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/screens/capture_photo_screen.dart';

class ImageHelper {
  static SizedBox buildImageBox(Uint8List? photoData){
   return SizedBox(
        width: 100,
        height: 100,
        child: Image.memory(photoData ?? Uint8List(0) ,
            fit: BoxFit.fill)

    );
  }

  static Container cameraPreviewBox(CameraController? controller){
   return Container(
      height: 400,
      width: 400,
      padding: const EdgeInsets.all(30),
      child: controller == null
          ? const Center(child: Text("Loading Camera..."))
          : !controller!.value.isInitialized
          ? const Center(child: CircularProgressIndicator())
          : CameraPreview(controller!),
    );
  }

  static Container capturedImageBox(CameraWidget widget){
    return Container(
      height: 400,
      width: 400,
      padding: const EdgeInsets.all(30),
      child: widget.photoData != null
          ? Image.memory(widget.photoData, height: 300)
          : const Text("No Photo"),
    );
  }
}