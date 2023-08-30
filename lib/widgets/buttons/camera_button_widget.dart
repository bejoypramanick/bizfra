import 'package:flutter/material.dart';

class CameraButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const CameraButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.camera),
      label: const Text("Take Photo"),
    );
  }
}
