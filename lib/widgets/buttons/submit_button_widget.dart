import 'package:flutter/material.dart';

import 'button_sized_box_widget.dart';

class SubmitButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const SubmitButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ButtonSizedBoxWidget(onPressed: onPressed, buttonTxt: 'SUBMIT');
  }
}
