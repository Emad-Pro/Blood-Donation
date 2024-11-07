import 'package:blood_donation/core/di/service_lacator.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/location_service/location_service.dart';
import 'package:blood_donation/core/widget/global_appbar.dart';
import 'package:blood_donation/core/widget/global_button.dart';
import 'package:blood_donation/hospital_layout/hospital_auth/hospital_signup/view_model/cubit/hospital_signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'hospital_signup_password_widget.dart';
import 'hospital_signup_phone_primary_contact_widget.dart';
import 'hospital_signup_time_opened_closed_widget.dart';
import 'widget/hospital_signup_location_dayes_widget.dart';
import 'widget/hospital_signup_title_sbtitle_name_email_widgets.dart';

class HospitalSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HospitalSignupCubit(getIt<LocationService>()),
      child: BlocBuilder<HospitalSignupCubit, HospitalSignupState>(
        builder: (context, state) {
          final hospitalSignupCubit = context.read<HospitalSignupCubit>();
          return Scaffold(
            appBar: globaleAppBar(context),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HospitalSignupTitleSubtitleNameEmailWidgets(
                      hospitalSignupCubit: hospitalSignupCubit),
                  HospitalSignupPhonePrimaryContactWidgets(
                      hospitalSignupCubit: hospitalSignupCubit),
                  HospitalSignupPasswordWidgets(
                      hospitalSignupCubit: hospitalSignupCubit),
                  HospitalSignupLocationDayesWidget(
                      hospitalSignupCubit: hospitalSignupCubit),
                  HospitalSignupTimeOpenedClosedWidgets(
                      hospitalSignupCubit: hospitalSignupCubit),
                  SizedBox(
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                      state.selectedDocsFiles[0].path
                                          .split('/')
                                          .last,
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
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      )
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GlobalButton(
                text: "Sign Up".tr(context),
                onTap: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
