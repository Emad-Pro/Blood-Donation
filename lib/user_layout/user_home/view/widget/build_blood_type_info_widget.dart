import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../core/tap_to_expand/src/tap_to_expand.dart';

class BuildBloodTypeInfoWidget extends StatelessWidget {
  const BuildBloodTypeInfoWidget({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      //   height: 160,
      child: TapToExpand(
        backgroundcolor:
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        content: Text(
          value,
          style: const TextStyle(fontSize: 20),
        ),
        title: Container(
          child: Text(
            "${title}",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        closedHeight: 70,
        spaceBetweenBodyTitle: 10,
        outerClosedPadding: 0,
        outerOpenedPadding: 10,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
