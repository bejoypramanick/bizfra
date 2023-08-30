import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget(
      {super.key,
      required this.hintText,
      required this.iconData,
      required this.isMandatory,
      required this.onChange,
      required this.onValidate,
      this.savedText});

  final String hintText;
  final IconData iconData;
  final bool isMandatory;
  final void Function(String newValue) onChange;
  final String? Function(String newValue) onValidate;
  final String? savedText;

  @override
  _ClearableTextFieldState createState() => _ClearableTextFieldState();
}

class _ClearableTextFieldState extends State<TextFieldWidget> {
  final TextEditingController _textEditingController = TextEditingController();
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
    return TextFormField(
      controller: _textEditingController,

      /*onEditingComplete: () {
        widget.onChange(_textEditingController.text);
      },*/
      onChanged: (newValue) {
        widget.onChange(newValue);
      },
      validator: (value) {
        widget.onValidate(value!);
      },
      decoration: InputDecoration(
        labelText: widget.hintText,
        // Initial hint
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
          borderSide: BorderSide(color: Colors.purple), // Border color on focus
        ),
      ),
    );
  }
}
