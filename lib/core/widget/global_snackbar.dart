import 'package:flutter/material.dart';

globalSnackbar(BuildContext context, String value, {Color? backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    content: Text(
      value,
      style: TextStyle(fontSize: 14),
    ),
    backgroundColor: backgroundColor,
  ));
}
