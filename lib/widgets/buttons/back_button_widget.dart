import 'package:bizfra/widgets/buttons/button_sized_box_widget.dart';
import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const BackButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ButtonSizedBoxWidget(onPressed: onPressed, buttonTxt: 'BACK');
  }
}
