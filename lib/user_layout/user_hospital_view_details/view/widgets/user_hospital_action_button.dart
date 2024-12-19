import 'package:flutter/material.dart';

class UserHospitalActionButton extends StatelessWidget {
  const UserHospitalActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.primaryColor,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final Color primaryColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
