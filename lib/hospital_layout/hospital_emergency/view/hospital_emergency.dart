import 'package:blood_donation/core/di/service_lacator.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/widget/globla_textformfiled.dart';
import 'package:blood_donation/hospital_layout/hospital_emergency/view_model/cubit/hospital_emergency_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalEmergency extends StatelessWidget {
  const HospitalEmergency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Alart Now".tr(context)),
      ),
      body: BlocBuilder<HospitalEmergencyCubit, HospitalEmergencyState>(
        bloc: getIt<HospitalEmergencyCubit>(),
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('When do you need the blood?'),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(value: 'Urgent', child: Text('Urgent')),
                    DropdownMenuItem(value: 'Today', child: Text('Today')),
                    DropdownMenuItem(
                        value: 'Tomorrow', child: Text('Tomorrow')),
                  ],
                  onChanged: (value) {
                    getIt<HospitalEmergencyCubit>().toggleTimeNeeded(value!);
                  },
                  hint: Text('Select Time'),
                ),
                SizedBox(height: 16),

                // Blood group
                Text('What blood group do you need?'),
                SizedBox(height: 8),
                GlobalTextFormFiled(
                  textEditingController:
                      getIt<HospitalEmergencyCubit>().bloodSelectedController,
                  readOnly: true,
                  onTap: () {
                    selectedBloodGroupModelBottomSheet(context);
                  },
                ),
                SizedBox(height: 16),

                Text('How many units are needed?'),
                SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  items: List.generate(
                    50,
                    (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text('${index + 1} Unit'),
                    ),
                  ),
                  onChanged: (value) {
                    getIt<HospitalEmergencyCubit>().toggleUnitsRequired(value!);
                  },
                  hint: Text('Select Units Required'),
                ),
                SizedBox(height: 16),

                // Location
                Text('Location Distance'),
                SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  items: List.generate(
                    10,
                    (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text('${index + 1} KM'),
                    ),
                  ),
                  onChanged: (value) {
                    getIt<HospitalEmergencyCubit>()
                        .toggleLocationDistance(value!);
                  },
                  hint: Text('Select Location Distance'),
                ),
                SizedBox(height: 32),

                // Request Button
              ],
            )),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            final state = getIt<HospitalEmergencyCubit>().state;
            print(state.unitsRequired);
            print(state.locationDistance);

            print(state.timeNeeded);
            print(getIt<HospitalEmergencyCubit>().bloodSelectedController.text);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Theme.of(context).colorScheme.surface,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Request Blood',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Future<dynamic> selectedBloodGroupModelBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        child: BlocBuilder<HospitalEmergencyCubit, HospitalEmergencyState>(
          bloc: getIt<HospitalEmergencyCubit>(),
          builder: (context, state) {
            return SizedBox(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select Blood Group"),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: state.bloodSelected.entries.map((entry) {
                            final disease = entry.key;
                            final isSelected = entry.value;
                            return CheckboxListTile(
                              title: Text(disease.tr(context)),
                              value: isSelected,
                              onChanged: (_) {
                                getIt<HospitalEmergencyCubit>()
                                    .toggleDiseaseSelection(disease);
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("confirm".tr(context))),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
