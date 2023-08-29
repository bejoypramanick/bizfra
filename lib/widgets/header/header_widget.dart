import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: Image.asset('assets/images/logo.png'),
        backgroundColor: Colors.black);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
