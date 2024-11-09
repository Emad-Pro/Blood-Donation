import 'package:flutter/material.dart';

globalSnackbar(BuildContext context, String value, {Color? backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.all(15),
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    content: Text(
      value,
      style: TextStyle(fontSize: 14),
    ),
    backgroundColor: backgroundColor,
  ));
}
