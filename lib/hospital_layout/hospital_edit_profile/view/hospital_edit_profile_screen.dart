import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/location_service/location_service.dart';
import 'package:blood_donation/core/widget/global_snackbar.dart';
import 'package:blood_donation/core/widget/globla_textformfiled.dart';
import 'package:blood_donation/hospital_layout/hospital_main/pages/hospital_profile_screen/view_model/cubit/hospital_profile_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/di/service_lacator.dart';
import '../../../core/enum/request_state.dart';
import '../../hospital_main/pages/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import '../view_model/cubit/hospital_edit_profile_cubit.dart';

class HospitalEditProfileScreen extends StatelessWidget {
  final HospitalProfileModel profile;

  const HospitalEditProfileScreen({Key? key, required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: BlocProvider(
        create: (context) =>
            HospitalEditProfileCubit(profile, LocationService()),
        child: BlocConsumer<HospitalEditProfileCubit, HospitalEditProfileState>(
          listener: (context, state) {
            if (state.updateProfileState == RequestState.success) {
              globalSnackbar(
                  context, "Profile Updated Successfully".tr(context),
                  backgroundColor: Colors.green);
              Navigator.pop(context);
              getIt<HospitalProfileCubit>().getInfo();
            } else if (state.updateProfileState == RequestState.error) {
              globalSnackbar(context, state.updateProfileMessage!,
                  backgroundColor: Colors.red);
            }
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
                  HospitalEditProfileOperatingDaysSelector(cubit: cubit),
                  SizedBox(height: 15),
                  HospitalEditProfilePWorkHoursSelector(cubit: cubit),
                  SizedBox(height: 15),
                  state.updateProfileState == RequestState.loading
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      Theme.of(context).colorScheme.primary),
                                  foregroundColor: WidgetStateProperty.all(
                                      Theme.of(context).colorScheme.surface)),
                              onPressed: () {
                                if (state.days!.isEmpty) {
                                  globalSnackbar(context,
                                      "Please Select Work Days".tr(context),
                                      backgroundColor: Colors.red);
                                } else {
                                  cubit.update();
                                }
                              },
                              child: Text("Update")))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class HospitalEditProfileEmailField extends StatelessWidget {
  final HospitalEditProfileCubit cubit;

  const HospitalEditProfileEmailField({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalTextFormFiled(
      readOnly: true,
      lableText: "Email".tr(context),
      textEditingController: cubit.emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'please enter your email'.tr(context);
        } else {
          return null;
        }
      },
    );
  }
}

class HospitalEditProfilePrimaryContactPersonRow extends StatelessWidget {
  final HospitalEditProfileCubit cubit;

  const HospitalEditProfilePrimaryContactPersonRow(
      {Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ServiceDropdown(
          selectedService: cubit.state.selectedPhoneServicePrimaryContactPerson,
          onServiceChanged: cubit.toggleServicePhonePrimaryContactNumber,
          serviceList: cubit.nameServicePhone,
        ),
        SizedBox(width: 8),
        Expanded(
          child: GlobalTextFormFiled(
            lableText: "Primary Contact Person".tr(context),
            keyboardType: TextInputType.phone,
            maxLength: 7,
            textEditingController: cubit.primaryContactPersonController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Primary Contact Person'.tr(context);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class HospitalEditProfilePhoneNumberRow extends StatelessWidget {
  final HospitalEditProfileCubit cubit;

  const HospitalEditProfilePhoneNumberRow({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ServiceDropdown(
          selectedService: cubit.state.selectedPhoneService,
          onServiceChanged: cubit.toggleServicePhone,
          serviceList: cubit.nameServicePhone,
        ),
        SizedBox(width: 8),
        Expanded(
          child: GlobalTextFormFiled(
            lableText: "Phone Number".tr(context),
            keyboardType: TextInputType.phone,
            maxLength: 7,
            textEditingController: cubit.phoneController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'please enter your phone number'.tr(context);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class HospitalEditProfileCurrentLocationField extends StatelessWidget {
  final HospitalEditProfileCubit cubit;

  const HospitalEditProfileCurrentLocationField({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalTextFormFiled(
      readOnly: true,
      onTap: () => cubit.getLocation(),
      iconButton: IconButton(
        onPressed: () => cubit.getLocation(),
        icon: Icon(Icons.location_on_outlined),
      ),
      lableText: "Current Location".tr(context),
      textEditingController: cubit.currentLocationController,
    );
  }
}

class HospitalEditProfileOperatingDaysSelector extends StatelessWidget {
  final HospitalEditProfileCubit cubit;

  const HospitalEditProfileOperatingDaysSelector(
      {Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (context) => HospitalEditProfileShowDayesScreen(
          hospitalEditProfileCubit: cubit,
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          cubit.state.days!.isEmpty
              ? "Select Operating Days".tr(context)
              : cubit.state.days!.length == 7
                  ? "All Days".tr(context)
                  : cubit.state.days!.join(', '),
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}

class HospitalEditProfilePWorkHoursSelector extends StatelessWidget {
  final HospitalEditProfileCubit cubit;

  const HospitalEditProfilePWorkHoursSelector({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => cubit.selectOpeningTime(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            if (cubit.state.openingTime != null)
              Text(cubit.state.openingTime!.format(context)),
            Text(cubit.state.openingTime == null
                ? "Work Hours".tr(context)
                : " - "),
            if (cubit.state.closingTime != null)
              Text(cubit.state.closingTime!.format(context)),
            Spacer(),
            Icon(Icons.timer_sharp),
            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}

class ServiceDropdown extends StatelessWidget {
  final String? selectedService;
  final List<String> serviceList;
  final Function(String) onServiceChanged;

  const ServiceDropdown({
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

class HospitalEditProfileShowDayesScreen extends StatelessWidget {
  const HospitalEditProfileShowDayesScreen(
      {Key? key, required this.hospitalEditProfileCubit})
      : super(key: key);
  final HospitalEditProfileCubit hospitalEditProfileCubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HospitalEditProfileCubit, HospitalEditProfileState>(
        bloc: hospitalEditProfileCubit,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("Select Operating Days".tr(context)),
                Expanded(
                  child: ListView(
                    children: state.daysOfWeek.map((day) {
                      return CheckboxListTile(
                        title: Text(day.tr(context)),
                        value: state.days!.contains(day) ||
                            (day == 'Select all' && state.allSelected),
                        onChanged: (_) =>
                            hospitalEditProfileCubit.toggleDay(day),
                      );
                    }).toList(),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Done".tr(context)))
              ],
            ),
          );
        },
      ),
    );
  }
}
