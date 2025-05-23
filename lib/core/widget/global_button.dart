import 'package:flutter/material.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton(
      {super.key, required this.text, required this.onTap, this.fontSize});
  final String text;
  final void Function()? onTap;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontSize: fontSize ?? 18,
                fontWeight: FontWeight.bold),
          ))),
    );
  }
}
