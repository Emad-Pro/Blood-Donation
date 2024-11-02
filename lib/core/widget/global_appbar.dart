import 'package:flutter/material.dart';

AppBar globaleAppBar(context) => AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logo/app_logo.png",
            width: 40,
            height: 40,
          ),
          SizedBox(
            width: 10,
          ),
          Text("Give Life")
        ],
      ),
    );
