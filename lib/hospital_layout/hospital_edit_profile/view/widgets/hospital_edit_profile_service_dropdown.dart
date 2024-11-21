// File for class ServiceDropdown

import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

class HospitalEditProfileServiceDropdown extends StatelessWidget {
  final String? selectedService;
  final List<String> serviceList;
  final Function(String) onServiceChanged;

  const HospitalEditProfileServiceDropdown({
    Key? key,
    required this.selectedService,
    required this.serviceList,
    required this.onServiceChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        underline: SizedBox(),
        isExpanded: true,
        value: selectedService ?? serviceList.first,
        items: serviceList.map((String service) {
          return DropdownMenuItem<String>(
            value: service,
            child: Text(service.tr(context), style: TextStyle(fontSize: 12)),
          );
        }).toList(),
        onChanged: (String? newValue) => onServiceChanged(newValue!),
      ),
    );
  }
}
