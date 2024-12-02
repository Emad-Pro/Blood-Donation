import 'package:flutter/material.dart';

import 'hospital_doner_build_doner_request_item.dart';

class HospitalDonerReceivedRequests extends StatelessWidget {
  const HospitalDonerReceivedRequests({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3, // Adjust based on the number of requests
      itemBuilder: (context, index) {
        return HospitalDonerBuildDonerRequestItem();
      },
    );
  }
}
