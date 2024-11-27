// File for class HospitalHomeEmergencyButton

import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/hospital_layout/hospital_emergency/view/hospital_emergency.dart';
import 'package:flutter/material.dart';

class HospitalHomeEmergencyButton extends StatelessWidget {
  const HospitalHomeEmergencyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HospitalEmergency()));
        },
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            height: MediaQuery.sizeOf(context).height * 0.15,
            width: 50,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/hospital_images/ambulance2.png"),
                  SizedBox(width: 25),
                  Text("Emergency Alart Now".tr(context),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
