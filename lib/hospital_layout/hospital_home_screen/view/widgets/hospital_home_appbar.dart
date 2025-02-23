// File for class HospitalHomeAppbar

import 'package:flutter/material.dart';

class HospitalHomeAppbar extends StatelessWidget {
  const HospitalHomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/logo/app_logo.png", height: 50, width: 50),
          SizedBox(width: 10),
          Text("Give Life",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
