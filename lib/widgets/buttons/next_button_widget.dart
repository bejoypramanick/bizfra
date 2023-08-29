import 'package:flutter/material.dart';

import 'button_sized_box_widget.dart';

class NextButtonWidget extends StatelessWidget {
  final VoidCallback? onButtonClicked;

  const NextButtonWidget({super.key,  this.onButtonClicked});

  @override
  Widget build(BuildContext context) {
    return ButtonSizedBoxWidget(onButtonPressed: onButtonClicked, buttonTxt: 'NEXT');
  }
}
