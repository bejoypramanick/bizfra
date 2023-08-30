import 'package:bizfra/widgets/autocomplete_txt_widget/AutoCompleteTextWidget.dart';
import 'package:flutter/material.dart';

import '../textfield/text_field_widget.dart';

class AutoCompleteTextFieldContainerWidget extends StatelessWidget {
  final List<String> suggestions;
  final bool isMandatory;
  final IconData iconData;
  final String hint;
  final String? savedText;
  final void Function(String newValue) onChange;

  const AutoCompleteTextFieldContainerWidget(
      {required this.iconData,
      required this.isMandatory,
      required this.onChange,
      required this.savedText,
      super.key,
      required this.suggestions,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(
          minWidth: 0,
          maxWidth: 600,
        ),
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.all(12.0), // Set margin for the Container
        child: AutoCompleteTextFieldWidget(
            iconData: iconData,
            isMandatory: isMandatory,
            suggestions: suggestions,
            hint: hint,
            onChange: onChange,
            savedText: savedText));
  }
}
