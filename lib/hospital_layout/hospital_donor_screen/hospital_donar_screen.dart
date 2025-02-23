import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';
import '../hospital_emergency/view/hospital_emergency.dart';
import '../received_history_emergency_donations/view/hospital_donor_received_requests_page/hospital_donor_received_requests_page.dart';

import '../received_history_emergency_donations/view/hospital_emergency/view/hospital_emergency_donations.dart';
import '../received_history_emergency_donations/view/hospital_request/hospital_my_request_page.dart';

class HospitalDonarScreen extends StatefulWidget {
  @override
  State<HospitalDonarScreen> createState() => _HospitalDonarScreenState();
}

class _HospitalDonarScreenState extends State<HospitalDonarScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Donors".tr(context)),
          bottom: TabBar(
            indicatorColor: Theme.of(context).colorScheme.primary,
            dividerColor: Colors.transparent,
            controller: tabController,
            tabs: [
              Tab(text: "Received Requests".tr(context)),
              Tab(text: "History Donations".tr(context)),
              Tab(text: "Emergency Donations".tr(context)),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            HospitalDonerReceivedRequestsPage(),
            HospitalMyRequestPage(),
            HospitalEmergencyDonations()
          ],
        ));
  }
}
