import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

class AutoCompleteTextFieldWidget extends StatefulWidget {
  final List<String> suggestions;
  final bool isMandatory;
  final IconData iconData;
  final String hint;
  final String? savedText;
  final void Function(String newValue) onChange;

  AutoCompleteTextFieldWidget(
      {super.key,
      required this.suggestions,
      required this.isMandatory,
      required this.iconData,
      required this.hint,
      required this.onChange, this.savedText});

  @override
  _AutoCompleteTextFieldState createState() => _AutoCompleteTextFieldState();
}

class _AutoCompleteTextFieldState extends State<AutoCompleteTextFieldWidget> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  TextEditingController _textEditingController = TextEditingController();
  AutoCompleteTextField<String>? textField;
  bool _showClearIcon = false;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_updateClearIconVisibility);
    _textEditingController.text = widget.savedText!;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _updateClearIconVisibility() {
    setState(() {
      _showClearIcon = _textEditingController.text.isNotEmpty;
    });
  }

  void _clearText() {
    _textEditingController.clear();
    setState(() {
      _showClearIcon = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return textField = AutoCompleteTextField<String>(
      key: key,
      controller: _textEditingController,
      textChanged: (value) => widget.onChange(value),
      clearOnSubmit: false,
      suggestions: widget.suggestions,
      decoration: InputDecoration(
          labelText: widget.hint,
          prefixIcon: Icon(widget.iconData,
              color: widget.isMandatory ? Colors.red : Colors.grey),
          suffixIcon: _showClearIcon
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _clearText,
                )
              : null,
          border: const OutlineInputBorder(),
          // Add border around the text field
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          // Hint label behavior
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.purple), // Border color on focus
          )),
      itemFilter: (item, query) {
        return item.toLowerCase().startsWith(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.compareTo(b);
      },
      itemSubmitted: (item) {
        setState(() {
          textField?.controller?.text = item;
        });
      },
      itemBuilder: (context, item) {
        return ListTile(
          title: Text(item),
        );
      },
    );
  }
}
