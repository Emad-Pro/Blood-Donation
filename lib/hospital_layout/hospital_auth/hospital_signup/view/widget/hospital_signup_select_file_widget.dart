import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/global_button.dart';
import '../../view_model/cubit/hospital_signup_cubit.dart';

class HospitalSignupSelectFileWidget extends StatelessWidget {
  const HospitalSignupSelectFileWidget(
      {super.key, required this.hospitalSignupCubit, required this.state});

  final HospitalSignupCubit hospitalSignupCubit;
  final HospitalSignupState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            SizedBox(
                width: 80,
                height: 40,
                child: GlobalButton(
                    text: "Select File".tr(context),
                    onTap: () {
                      hospitalSignupCubit.pickMultipleFiles();
                    },
                    fontSize: 14)),
            Expanded(
              child: Row(
                children: [
                  SizedBox(width: 10),
                  if (state.selectedDocsFiles.isNotEmpty)
                    Expanded(
                      child: Text(
                        state.selectedDocsFiles[0].path.split('/').last,
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (state.selectedDocsFiles.isEmpty)
                    Text("${"Selected File".tr(context)} (0)"),
                  if (state.selectedDocsFiles.isNotEmpty)
                    IconButton(
                        onPressed: () {
                          hospitalSignupCubit.deletePickFile();
                        },
                        icon: Icon(Icons.delete))
                ],
              ),
            ),
            SizedBox(width: 15),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "Please provide proof of your hospital's/center's blood donation authorisation"
              .tr(context),
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        )
      ],
    );
  }
}
