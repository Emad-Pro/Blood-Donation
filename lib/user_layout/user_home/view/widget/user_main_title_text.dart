import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

class UserMainTitleText extends StatelessWidget {
  const UserMainTitleText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color:
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)),
        child: Text(title.tr(context), style: TextStyle(fontSize: 16)));
  }
}
