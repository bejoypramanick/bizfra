import 'package:flutter/cupertino.dart';

class HeaderTitlePaddingWidget extends StatelessWidget {
  final String headerTitle;

  const HeaderTitlePaddingWidget({super.key, required this.headerTitle});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        headerTitle,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
