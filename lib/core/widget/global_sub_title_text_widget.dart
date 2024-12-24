import 'package:flutter/material.dart';

import '../style/colors.dart';

class GlobalSubTitleTextWidget extends StatelessWidget {
  const GlobalSubTitleTextWidget({super.key, required this.subTitle});
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle,
      style: const TextStyle(
          fontWeight: FontWeight.w400,
          //    fontFamily: AppFonts.primaryFont,
          color: AppColors.greyLightColor),
    );
  }
}
