import 'package:bizfra/widgets/buttons/button_sized_box_widget.dart';
import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback? onButtonClicked;

  const BackButtonWidget({super.key,  this.onButtonClicked});

  @override
  Widget build(BuildContext context) {
    return ButtonSizedBoxWidget(onButtonPressed: onButtonClicked, buttonTxt: 'BACK');
  }
}
