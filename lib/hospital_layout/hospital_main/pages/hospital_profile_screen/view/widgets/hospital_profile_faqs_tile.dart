// File for class HospitalProfileFaqsTile

import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../../hospital_faqs/view/hospital_faqs_screen.dart';

class HospitalProfileFAGSTile extends StatelessWidget {
  const HospitalProfileFAGSTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      title: Text("FAQs".tr(context)),
      leading: CircleAvatar(child: Icon(Icons.feed)),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HospitalFaqsScreen()));
      },
    );
  }
}