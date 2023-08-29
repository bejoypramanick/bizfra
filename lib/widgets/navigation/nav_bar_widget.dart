import 'package:bizfra/widgets/buttons/button_sized_box_widget.dart';
import 'package:flutter/material.dart';

import '../buttons/back_button_widget.dart';
import '../buttons/next_button_widget.dart';

class BottomNavBarWidget extends StatelessWidget {
   final BackButtonWidget backButtonWidget;
   final NextButtonWidget nextButtonWidget;

   const BottomNavBarWidget({super.key, required this.backButtonWidget, required this.nextButtonWidget});

  @override
  Widget build(BuildContext context) {
    return  BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          backButtonWidget,
          nextButtonWidget
        ],
      ),
    );
  }
}
