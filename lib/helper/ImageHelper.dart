import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class ImageHelper {
  static SizedBox buildImageBox(Uint8List? photoData){
   return SizedBox(
        width: 100,
        height: 100,
        child: Image.memory(photoData ?? Uint8List(0) ,
            fit: BoxFit.fill)

    );
  }
}