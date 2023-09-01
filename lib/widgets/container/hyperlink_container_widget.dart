import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HyperlinkContainerWidget extends StatelessWidget {
  const HyperlinkContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'I accept the ',
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: 'terms and conditions',
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Implement your navigation or dialog to show terms and conditions here
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Terms and Conditions'),
                      content: const Text('This is where your terms and conditions text would go.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
          ),
        ],
      ),
    );
  }
}
