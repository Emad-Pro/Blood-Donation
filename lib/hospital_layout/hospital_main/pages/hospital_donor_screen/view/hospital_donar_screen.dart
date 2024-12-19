import 'package:flutter/material.dart';
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
          title: const Text("Donors"),
          bottom: TabBar(
            indicatorColor: Theme.of(context).colorScheme.primary,
            dividerColor: Colors.transparent,
            controller: tabController,
            tabs: [
              Tab(text: "Received Requests"),
              Tab(text: "History Donations"),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [HospitalDonerReceivedRequests(), HospitalMyRequestPage()],
        ));
  }
}
