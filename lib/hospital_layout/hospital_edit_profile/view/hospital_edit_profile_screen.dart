import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/location_service/location_service.dart';
import 'package:blood_donation/core/shared_preferences/cache_helper.dart';
import 'package:blood_donation/core/widget/globla_textformfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widget/global_button.dart';
import '../../hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
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
  final bool isReview;
  const HospitalEditProfileScreen(
      {Key? key, required this.profile, this.isReview = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile".tr(context),
        ),
        actions: [],
      ),
      body: BlocProvider(
        create: (context) =>
            HospitalEditProfileCubit(profile, LocationService()),
        child: BlocConsumer<HospitalEditProfileCubit, HospitalEditProfileState>(
          listener: (context, state) {
            hospitalEditProfileListener(state, context);
          },
          builder: (context, state) {
            final cubit = context.read<HospitalEditProfileCubit>();
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: cubit.formKey,
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
                    Row(
                      children: [
                        SizedBox(
                            width: 80,
                            height: 40,
                            child: GlobalButton(
                                text: "Select File".tr(context),
                                onTap: () {
                                  cubit.pickMultipleFiles();
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
                                      cubit.deletePickFile();
                                    },
                                    icon: Icon(Icons.delete))
                            ],
                          ),
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: HospitalEditProfileUpdateButtonWidget(
                              isReview: isReview, cubit: cubit, state: state),
                        ),
                        SizedBox(width: 10),
                        if (isReview)
                          HospitalEditPorfileChangePasswordButton(cubit: cubit),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HospitalEditPorfileChangePasswordButton extends StatelessWidget {
  const HospitalEditPorfileChangePasswordButton(
      {super.key, required this.cubit});
  final HospitalEditProfileCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HospitalEditProfileChangePasswords(cubit: cubit);
          }));
        },
        child: Text("Edit Password".tr(context)),
      ),
    );
  }
}

class HospitalEditProfileChangePasswords extends StatelessWidget {
  const HospitalEditProfileChangePasswords({Key? key, required this.cubit})
      : super(key: key);
  final HospitalEditProfileCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password".tr(context)),
      ),
      body: BlocBuilder<HospitalEditProfileCubit, HospitalEditProfileState>(
        bloc: cubit,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: cubit.changePasswordKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    GlobalTextFormFiled(
                        isSecure: state.oldPasswordIsSecure,
                        iconButton: IconButton(
                            onPressed: () {
                              cubit.toggleShowOldPassowrd();
                            },
                            icon: state.oldPasswordIsSecure == true
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                        lableText: "Old Password".tr(context),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Old Password".tr(context);
                          } else if (CacheHelper.getSaveData(key: "password") !=
                              value) {
                            return "Old Password Not Match".tr(context);
                          } else
                            return null;
                        }),
                    SizedBox(
                      height: 12,
                    ),
                    GlobalTextFormFiled(
                        isSecure: state.newPsswordIsSecure,
                        iconButton: IconButton(
                            onPressed: () {
                              cubit.toggleShowNewPassowrd();
                            },
                            icon: state.newPsswordIsSecure == true
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                        textEditingController: cubit.passwordController,
                        lableText: "New Password".tr(context),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter new password".tr(context);
                          } else if (value !=
                              cubit.confirmPasswordController.text) {
                            return "Password Not Match".tr(context);
                          } else
                            return null;
                        }),
                    SizedBox(
                      height: 12,
                    ),
                    GlobalTextFormFiled(
                        isSecure: state.newPsswordIsSecure,
                        iconButton: IconButton(
                            onPressed: () {
                              cubit.toggleShowNewPassowrd();
                            },
                            icon: state.newPsswordIsSecure == true
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                        textEditingController: cubit.confirmPasswordController,
                        lableText: "Confirm new Password".tr(context),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Password".tr(context);
                          } else if (value !=
                              cubit.confirmPasswordController.text) {
                            return "Password Not Match".tr(context);
                          } else
                            return null;
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (cubit.changePasswordKey.currentState!
                              .validate()) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                        title:
                                            Text("Change Password".tr(context)),
                                        content: Text(
                                            "Are you sure to change password"
                                                .tr(context)),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child:
                                                  Text("Cancel".tr(context))),
                                          TextButton(
                                              onPressed: () =>
                                                  cubit.changePassword(),
                                              child:
                                                  Text("Confirm".tr(context)))
                                        ]));
                          }
                        },
                        child: Text("Change Password".tr(context))),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
