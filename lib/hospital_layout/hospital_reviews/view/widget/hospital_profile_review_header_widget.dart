import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/hospital_layout/hospital_reviews/view_model/cubit/hospital_review_cubit.dart';
import 'package:flutter/material.dart';
import 'package:rating_summary/rating_summary.dart';

import '../methods/calc_avergs.dart';

class HospitalProfileReviewHeaderWidget extends StatelessWidget {
  const HospitalProfileReviewHeaderWidget(
      {super.key, required this.state, required this.cubit});
  final HospitalReviewState state;
  final HospitalReviewCubit cubit;
  @override
  Widget build(BuildContext context) {
    final values = cubit
        .calculateRatingsDistribution(state.hospitalReviewModel!)
        .values
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${"Ratings & Reviews".tr(context)} (${state.hospitalReviewModel!.length})",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        RatingSummary(
          color: Theme.of(context).colorScheme.primary,
          counter: cubit.state.hospitalReviewModel!.length,
          average: calculateAverageRating(state.hospitalReviewModel!),
          showAverage: true,
          counterFiveStars: values[4],
          counterFourStars: values[3],
          counterThreeStars: values[2],
          counterTwoStars: values[1],
          counterOneStars: values[0],
        ),
        SizedBox(height: 16),
        Text(
          "Reviews".tr(context),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
