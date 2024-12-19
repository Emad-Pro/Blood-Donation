import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import '../../../../../../main.dart';

class UserMainHomeScreen extends StatelessWidget {
  const UserMainHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          onPressed: () async {
            // await Workmanager()
            //     .initialize(callbackDispatcher, isInDebugMode: true);
            // callbackDispatcher();
          },
          child: Text("Home")),
    );
  }
}
