// File for class HospitalProfileReviewsTile

import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../hospital_reviews/view/hospital_review_screen.dart';

class HospitalProfileReviewsTile extends StatelessWidget {
  const HospitalProfileReviewsTile({
    super.key,
    required this.hospitalName,
  });
  final String hospitalName;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      title: Text("Reviews".tr(context)),
      leading: CircleAvatar(child: Icon(Icons.comment_sharp)),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HospitalReviewScreen(
                      hospitalName: hospitalName,
                    )));
      },
    );
  }
}
