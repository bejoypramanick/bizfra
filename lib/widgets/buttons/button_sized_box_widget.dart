import 'package:bizfra/widgets/styles/nav_button_style.dart';
import 'package:flutter/material.dart';

class ButtonSizedBoxWidget extends StatelessWidget {
  final VoidCallback onPressed;
  String buttonTxt;

  ButtonSizedBoxWidget(
      {super.key, required this.onPressed, required this.buttonTxt});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120.0,
        height: 50.0,
        child: OutlinedButton(
            onPressed: () {
              onPressed();
            },
            style: NavButtonStyle.outlinedButtonStyle,
            child: Text(buttonTxt, style: NavButtonStyle.buttonText)));
  }
}
