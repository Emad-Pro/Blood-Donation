import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/globla_textformfiled.dart';
import '../../view_model/cubit/hospital_signup_cubit.dart';
import '../hospital_signup_show_dayes_widget.dart';

class HospitalSignupLocationDayesWidget extends StatelessWidget {
  const HospitalSignupLocationDayesWidget({
    super.key,
    required this.hospitalSignupCubit,
  });

  final HospitalSignupCubit hospitalSignupCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlobalTextFormFiled(
          lableText: "Current Location".tr(context),
          textEditingController: hospitalSignupCubit.currentLocationController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please Enter Current Location".tr(context);
            } else {
              return null;
            }
          },
          readOnly: true,
          iconButton: IconButton(
              onPressed: () async {
                await hospitalSignupCubit.getLocation();
              },
              icon: Icon(Icons.location_on)),
        ),
        SizedBox(height: 15),
        GestureDetector(
          onTap: () => showModalBottomSheet(
            builder: (context) => HospitalSignupShowDayesWidget(
                hospitalSignupCubit: hospitalSignupCubit),
            context: context,
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              hospitalSignupCubit.state.selectedDays.isEmpty
                  ? "Select Operating Days".tr(context)
                  : hospitalSignupCubit.state.selectedDays.length == 7
                      ? "All Days".tr(context)
                      : hospitalSignupCubit.state.selectedDays.join(', '),
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
