import 'package:flutter/material.dart';

class UserMainHomeScreen extends StatelessWidget {
  const UserMainHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home_outlined,
            size: 100,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(height: 20),
          Text("Home Screen")
        ],
      ),
    );
  }
}
