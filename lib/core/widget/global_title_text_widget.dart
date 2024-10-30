import 'package:flutter/material.dart';

import '../style/fonts.dart';

class GlobalTitleTextWidget extends StatelessWidget {
  const GlobalTitleTextWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: AppFonts.primaryFont,
          fontSize: 24,
          color: Theme.of(context).colorScheme.primary),
    );
  }
}
