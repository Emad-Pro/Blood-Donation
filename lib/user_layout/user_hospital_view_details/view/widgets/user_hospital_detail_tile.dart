import 'package:flutter/material.dart';

class UserHospitalDetailTile extends StatelessWidget {
  const UserHospitalDetailTile(
      {Key? key,
      required this.icon,
      required this.text,
      required this.primaryColor})
      : super(key: key);

  final IconData icon;
  final String text;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: primaryColor),
          title: Text(text),
        ),
        Divider(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
        ),
      ],
    );
  }
}
