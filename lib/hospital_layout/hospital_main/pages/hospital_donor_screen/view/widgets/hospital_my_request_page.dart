import 'package:flutter/material.dart';
import 'hospital_doner_build_my_request_pending.dart';

class HospitalMyRequestPage extends StatelessWidget {
  const HospitalMyRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        if (index % 2 == 0) {
          return HospitalDonerBuildMyRequestPending(
            isReject: true,
          );
        } else
          return HospitalDonerBuildMyRequestPending();
      },
    );
  }
}
