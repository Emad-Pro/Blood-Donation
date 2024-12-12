import 'package:flutter/material.dart';

class UserHospitalImageContainer extends StatelessWidget {
  const UserHospitalImageContainer({Key? key, required this.primaryColor})
      : super(key: key);

  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor.withOpacity(0.7),
      width: double.infinity,
      height: 170,
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        "assets/images/hospital_images/20228510_6271988.png",
        height: 150,
        fit: BoxFit.fill,
      ),
    );
  }
}
