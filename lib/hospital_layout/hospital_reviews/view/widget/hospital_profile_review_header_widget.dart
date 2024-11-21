import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/hospital_layout/hospital_reviews/view_model/cubit/hospital_review_cubit.dart';
import 'package:flutter/material.dart';

import '../methods/calc_avergs.dart';

class HospitalProfileReviewHeaderWidget extends StatelessWidget {
  const HospitalProfileReviewHeaderWidget({super.key, required this.state});
  final HospitalReviewState state;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${"Ratings & Reviews".tr(context)} (${state.hospitalReviewModel!.length})",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: List.generate(5, (index) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "${5 - index}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: LinearProgressIndicator(
                          value: [0.8, 0.6, 0.4, 0.1, 0.05][index],
                          //     backgroundColor: Colors.grey[300],
                          color: primaryColor,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    calculateAverageRating(state.hospitalReviewModel!)
                        .toString(),
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                      "${state.hospitalReviewModel!.length} ${"Reviews".tr(context)}"),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          "Reviews",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
