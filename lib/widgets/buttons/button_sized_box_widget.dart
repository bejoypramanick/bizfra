import 'package:bizfra/widgets/styles/nav_button_style.dart';
import 'package:flutter/material.dart';

class ButtonSizedBoxWidget extends StatelessWidget {
  final VoidCallback? onButtonPressed;
  String buttonTxt;

  ButtonSizedBoxWidget(
      {super.key,  this.onButtonPressed, required this.buttonTxt});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120.0,
        height: 50.0,
        child: OutlinedButton(
            onPressed: onButtonPressed,
            style: NavButtonStyle.outlinedButtonStyle,
            child: Text(buttonTxt, style: NavButtonStyle.buttonText)));
  }
}
