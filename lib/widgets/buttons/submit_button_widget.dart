import 'package:bizfra/widgets/buttons/next_button_widget.dart';
import 'package:flutter/material.dart';

import 'button_sized_box_widget.dart';

class SubmitButtonWidget extends NextButtonWidget {
  final VoidCallback? onButtonClicked;

  const SubmitButtonWidget({super.key,  this.onButtonClicked});

  @override
  Widget build(BuildContext context) {
    return ButtonSizedBoxWidget(onButtonPressed: onButtonClicked, buttonTxt: 'SUBMIT');
  }
}
