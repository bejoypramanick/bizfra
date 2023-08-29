import 'package:flutter/material.dart';

class NavButtonStyle {
  static const TextStyle buttonText = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: Colors.deepPurple,
  );

  static ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      side: const BorderSide(color: Colors.transparent, width: 2.0),
      padding: const EdgeInsets.all(15.0));

// Define more styles or themes as needed
}
