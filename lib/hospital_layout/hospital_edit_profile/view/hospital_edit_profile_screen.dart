import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/location_service/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../hospital_main/pages/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import '../view_model/cubit/hospital_edit_profile_cubit.dart';
import 'widgets/hospital_edit_profile_current_location_field.dart';
import 'widgets/hospital_edit_profile_email_field.dart';
import 'widgets/hospital_edit_profile_listener.dart';
import 'widgets/hospital_edit_profile_operating_days_selector.dart';
import 'widgets/hospital_edit_profile_phone_number_row.dart';
import 'widgets/hospital_edit_profile_primary_contact_person_row.dart';
import 'widgets/hospital_edit_profile_update_button_widget.dart';
import 'widgets/hospital_edit_profile_work_hours_selector.dart';

class HospitalEditProfileScreen extends StatelessWidget {
  final HospitalProfileModel profile;

  const HospitalEditProfileScreen({Key? key, required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile".tr(context)),
      ),
      body: BlocProvider(
        create: (context) =>
            HospitalEditProfileCubit(profile, LocationService()),
        child: BlocConsumer<HospitalEditProfileCubit, HospitalEditProfileState>(
          listener: (context, state) {
            hospitalEditProfileListener(state, context);
          },
          builder: (context, state) {
            print(Supabase.instance.client.auth.currentUser!.id);
            final cubit = context.read<HospitalEditProfileCubit>();
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HospitalEditProfileEmailField(cubit: cubit),
                  SizedBox(height: 15),
                  HospitalEditProfilePrimaryContactPersonRow(cubit: cubit),
                  SizedBox(height: 15),
                  HospitalEditProfilePhoneNumberRow(cubit: cubit),
                  SizedBox(height: 15),
                  HospitalEditProfileCurrentLocationField(cubit: cubit),
                  SizedBox(height: 15),
                  HospitalEditProfileOperatingDaysSelector(
                      cubit: cubit, state: state),
                  SizedBox(height: 15),
                  HospitalEditProfileWorkHoursSelector(cubit: cubit),
                  SizedBox(height: 15),
                  HospitalEditProfileUpdateButtonWidget(
                      cubit: cubit, state: state)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
