import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/global_sub_title_text_widget.dart';
import '../../../../../core/widget/global_title_text_widget.dart';

class UserSignupTitleSubtitleWidgets extends StatelessWidget {
  const UserSignupTitleSubtitleWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlobalTitleTextWidget(title: "Create Account".tr(context)),
        SizedBox(
          height: 8,
        ),
        GlobalSubTitleTextWidget(
            subTitle:
                "Register now and start exploring all the features our app has to offer. We're excited to have you join our community of donors and help save lives!"
                    .tr(context)),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
