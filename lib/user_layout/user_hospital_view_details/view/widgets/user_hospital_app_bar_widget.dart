import 'package:flutter/material.dart';

class UserHospitalAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;

  const UserHospitalAppBarWidget({super.key, this.title});
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return AppBar(
      title: Text(title!),
      backgroundColor: primaryColor.withOpacity(0.7),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.star_rounded)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
