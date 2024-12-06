import 'package:flutter/material.dart';

class UserProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;

  const UserProfileOptionTile(
      {Key? key, required this.icon, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      onTap: onTap,
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: Icon(Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
    );
  }
}
