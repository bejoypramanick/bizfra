import 'package:flutter/material.dart';

import '../calendar/calender_widget.dart';

class CalendarContainerWidget extends StatelessWidget {
  final bool isMandatory;
  final void Function(String newValue) onChange;
  final String? Function(String newValue) onValidate;
  final String? savedText;

  const CalendarContainerWidget(
      {required this.isMandatory,
      required this.onChange,
      required this.onValidate,
      required this.savedText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(
          minWidth: 0,
          maxWidth: 600,
        ),
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.all(12.0), // Set margin for the Container
        child: CalenderWidget(
            isMandatory: isMandatory,
            onChange: onChange,
            onValidate: onValidate,
            savedText: savedText));
  }
}
