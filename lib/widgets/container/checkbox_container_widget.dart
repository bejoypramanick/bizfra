import 'package:bizfra/widgets/autocomplete_txt_widget/AutoCompleteTextWidget.dart';
import 'package:flutter/material.dart';

import '../textfield/text_field_widget.dart';

class CheckboxContainerWidget extends StatefulWidget {
  const CheckboxContainerWidget({super.key});

  @override
  _CheckboxStateState createState() => _CheckboxStateState();
}
class _CheckboxStateState extends State<CheckboxContainerWidget>
{

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _isChecked,
      onChanged: (bool? newValue) {
        setState(() {
          _isChecked = newValue!;
        });
      },
    );
  }
}
