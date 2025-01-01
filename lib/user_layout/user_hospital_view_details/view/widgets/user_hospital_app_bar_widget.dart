import 'package:flutter/material.dart';

import '../../../user_view_review_hospital/view/user_view_review_hospital_screen.dart';

class UserHospitalAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final String hospitalUid;
  const UserHospitalAppBarWidget(
      {super.key, this.title, required this.hospitalUid});
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return AppBar(
      title: Text(title!),
      backgroundColor: primaryColor.withOpacity(0.7),
      actions: [
        IconButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => UserViewReviewHospitalScreen(
              //             hospitalUid: hospitalUid)));
            },
            icon: const Icon(Icons.star_rounded)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
