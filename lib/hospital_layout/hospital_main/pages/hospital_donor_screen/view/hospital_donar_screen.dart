import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';
import '../pages/hospital_donor_received_requests_page/view/hospital_donor_received_requests_page.dart';
import 'widgets/hospital_doner_received_requeests.dart';
import 'widgets/hospital_my_request_page.dart';

class HospitalDonarScreen extends StatefulWidget {
  @override
  State<HospitalDonarScreen> createState() => _HospitalDonarScreenState();
}

class _HospitalDonarScreenState extends State<HospitalDonarScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
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
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            HospitalDonerReceivedRequestsPage(),
            HospitalMyRequestPage()
          ],
        ));
  }
}
