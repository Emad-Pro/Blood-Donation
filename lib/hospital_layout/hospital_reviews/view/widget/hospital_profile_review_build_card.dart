import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

class HospitalProfileReviewBuildCard extends StatelessWidget {
  const HospitalProfileReviewBuildCard({
    super.key,
    required this.rating,
    required this.name,
    required this.text,
    required this.bloodType,
  });
  final double rating;
  final String name;
  final String text;
  final String bloodType;

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
                        name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${"Blood type".tr(context)}: $bloodType",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(rating.toInt(), (index) {
                    return Icon(Icons.star, color: Colors.orange, size: 18);
                  }),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              text,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
