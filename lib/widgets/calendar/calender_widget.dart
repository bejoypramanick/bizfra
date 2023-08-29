import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget(
      {super.key,
      required this.isMandatory,
      required this.onChange,
      required this.onValidate});

  final bool isMandatory;
  final void Function(String newValue) onChange;
  final String? Function(String newValue) onValidate;

  @override
  _DatePickerTextFieldState createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<CalenderWidget> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime lastDate =
        currentDate.subtract(const Duration(days: 18 * 365));
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd-MMM-yyyy').format(_selectedDate!);
        widget.onValidate(_dateController.text);
        widget.onChange(_dateController.text);
      });
    }
  }

  void _clearDate() {
    setState(() {
      _selectedDate = null;
      _dateController.clear();
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextField(
          controller: _dateController,
          readOnly: true,
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
            labelText: 'Date of Birth',
            prefixIcon: Icon(Icons.calendar_month_sharp,
                color: widget.isMandatory ? Colors.red : Colors.grey),
            suffixIcon: _selectedDate != null
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _clearDate,
                  )
                : null,
            border: const OutlineInputBorder(),
            // Add border around the text field
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            // Hint label behavior
            focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.purple), // Border color on focus
            ),
          ),
        ),
      ],
    );
  }
}
