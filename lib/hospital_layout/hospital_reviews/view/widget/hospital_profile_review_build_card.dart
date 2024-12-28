import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/hospital_layout/hospital_reviews/model/hospital_review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/auto_direction.dart';

class HospitalProfileReviewBuildCard extends StatelessWidget {
  const HospitalProfileReviewBuildCard({super.key, required this.review});
  final HospitalReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reviewer Info
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${"Blood type".tr(context)}: ${review.userBloodType}",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(" (${review.rating.toString()})"),
                    RatingBarIndicator(
                      rating: review.rating!,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            AutoDirection(
              text: review.review!,
              child: Text(review.review!),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
