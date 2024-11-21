import 'package:flutter/material.dart';

import '../../view_model/cubit/hospital_profile_cubit.dart';

class HospitalProfileHeaderWidgets extends StatelessWidget {
  const HospitalProfileHeaderWidgets({super.key, required this.state});
  final HospitalProfileState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 35),
        CircleAvatar(
          radius: 50,
          backgroundColor:
              Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
          child: Center(
            child: Icon(
              Icons.local_hospital,
              size: 55,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
        Text(state.hospitalProfileModel!.name!,
            style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold)),
        Container(
          width: 300,
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  state.hospitalProfileModel!.currentLocation!,
                  softWrap: true,
                  maxLines: 1,
                  style: TextStyle(
                    color:
                        Theme.of(context).colorScheme.surface.withOpacity(0.7),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
