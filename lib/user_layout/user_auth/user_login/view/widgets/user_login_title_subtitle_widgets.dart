import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/global_sub_title_text_widget.dart';
import '../../../../../core/widget/global_title_text_widget.dart';

class UserLoginTitleSubtitleWidgets extends StatelessWidget {
  const UserLoginTitleSubtitleWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlobalTitleTextWidget(title: 'Welcome Back'.tr(context)),
        const SizedBox(
          height: 15,
        ),
        GlobalSubTitleTextWidget(
            subTitle:
                "We're excited to have you back! We can't wait to see the impact you've made since you last used the app."
                    .tr(context)),
        const SizedBox(height: 30),
      ],
    );
  }
}
