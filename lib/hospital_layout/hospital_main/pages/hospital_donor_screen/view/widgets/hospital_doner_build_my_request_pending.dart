import 'package:flutter/material.dart';

class HospitalDonerBuildMyRequestPending extends StatelessWidget {
  const HospitalDonerBuildMyRequestPending({super.key, this.isReject = false});
  final bool isReject;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  // Blood Group Widget
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.bloodtype,
                              color: Colors.red,
                              size: 30,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "AB+",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text("0.3 Unit"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Request Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Female, 21yr old",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text("kirthika"),
                        Text("rediyarpalayam, puducherry"),
                        SizedBox(height: 5),
                        Text("3 Km"),
                        SizedBox(height: 5),
                        Text(
                          "AGS Hospital, Moolakulam",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Call Icon
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            if (isReject==false)      Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      const SizedBox(width: 5),
                      const Text(
                        "Request accepted",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      // Donor Info Button
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.info,
                          color: Colors.blue,
                        ),
                        label: const Text(
                          "donor info",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              if (isReject)
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.close, color: Colors.red),
                        const SizedBox(width: 5),
                        const Text(
                          "Request Rejected",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        // Donor Info Button
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.info,
                            color: Colors.blue,
                          ),
                          label: const Text(
                            "donor info",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
