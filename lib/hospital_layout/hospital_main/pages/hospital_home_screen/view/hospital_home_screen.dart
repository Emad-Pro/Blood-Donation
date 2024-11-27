import 'package:flutter/material.dart';
import 'widgets/hospital_home_appbar.dart';
import 'widgets/hospital_home_emergency_button.dart';
import 'widgets/hospital_home_resent_listview.dart';
import 'widgets/hospital_home_resent_text.dart';
import 'widgets/hospital_home_slider.dart';

class HospitalHomeScreen extends StatelessWidget {
  const HospitalHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0, left: 15, right: 15),
      child: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          HospitalHomeAppbar(),
          HospitalHomeSlider(),
          HospitalHomeEmergencyButton(),
          HospitalHomeResentText(),
          HospitalHomeResentListview()
        ],
      ),
    );
  }
}
