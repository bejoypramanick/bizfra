import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  var widget;
  var property;

  ContainerWidget({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(
          minWidth: 0,
          maxWidth: 600,
        ),
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.all(12.0), // Set margin for the Container
        child: widget);
  }
}
