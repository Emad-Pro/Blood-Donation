import 'package:flutter/material.dart';

import '../../../../core/video_player/video_player.dart';

class UserMainHomeCarouselWidget extends StatelessWidget {
  const UserMainHomeCarouselWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
            color:
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.6)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: VideoCarouselScreen(),
    );
  }
}
