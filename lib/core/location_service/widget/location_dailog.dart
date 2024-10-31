import 'package:flutter/material.dart';

void showPermissionDialog(
    {required BuildContext context, required void Function()? onPressed}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('إذن الموقع مرفوض'),
        content: Text(
            'يرجى السماح بالوصول إلى الموقع من الإعدادات لتتمكن من استخدام هذه الميزة.'),
        actions: <Widget>[
          TextButton(
            child: Text('فتح الإعدادات'),
            onPressed: onPressed,
          ),
          TextButton(
            child: Text('إلغاء'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
