import 'package:blood_donation/core/di/service_lacator.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/location_service/location_service.dart';
import 'package:blood_donation/core/widget/global_appbar.dart';
import 'package:blood_donation/core/widget/global_button.dart';
import 'package:blood_donation/hospital_layout/hospital_auth/hospital_signup/view_model/cubit/hospital_signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/global_snackbar.dart';
import 'hospital_signup_password_widget.dart';
import 'hospital_signup_phone_primary_contact_widget.dart';
import 'hospital_signup_time_opened_closed_widget.dart';
import 'listener/hospital_signup_listener.dart';
import 'widget/hospital_signup_location_dayes_widget.dart';
import 'widget/hospital_signup_select_file_widget.dart';
import 'widget/hospital_signup_title_sbtitle_name_email_widgets.dart';

class HospitalSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HospitalSignupCubit(getIt<LocationService>()),
      child: BlocConsumer<HospitalSignupCubit, HospitalSignupState>(
        listener: (context, state) {
          listenerHospitalSignin(state, context);
        },
        builder: (context, state) {
          final hospitalSignupCubit = context.read<HospitalSignupCubit>();
          return Scaffold(
            appBar: globaleAppBar(context),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: hospitalSignupCubit.formKey,
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
                    HospitalSignupSelectFileWidget(
                        hospitalSignupCubit: hospitalSignupCubit, state: state),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GlobalButton(
                text: "Sign Up".tr(context),
                onTap: () async {
                  if (hospitalSignupCubit.formKey.currentState!.validate()) {
                    if (state.selectedDays.isEmpty) {
                      globalSnackbar(
                          context, "Please Select Work Days".tr(context),
                          backgroundColor: Colors.red);
                    } else if (state.openingTime == null ||
                        state.closingTime == null) {
                      globalSnackbar(
                          context, "Please Select Work Hours".tr(context),
                          backgroundColor: Colors.red);
                    } else if (state.selectedDocsFiles.isEmpty) {
                      globalSnackbar(context, "Please upload docs".tr(context),
                          backgroundColor: Colors.red);
                    } else {
                      await hospitalSignupCubit
                          .signupHospitalWithEmailAndPassword();
                    }
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
