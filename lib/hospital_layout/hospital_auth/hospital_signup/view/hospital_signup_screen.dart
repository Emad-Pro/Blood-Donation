import 'package:blood_donation/core/widget/global_button.dart';
import 'package:blood_donation/core/widget/global_sub_title_text_widget.dart';
import 'package:blood_donation/core/widget/global_title_text_widget.dart';
import 'package:blood_donation/core/widget/globla_textformfiled.dart';
import 'package:blood_donation/hospital_layout/hospital_auth/hospital_signup/view_model/cubit/hospital_signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HospitalSignupCubit(),
      child: BlocBuilder<HospitalSignupCubit, HospitalSignupState>(
        builder: (context, state) {
          final hospitalSignupCubit = context.read<HospitalSignupCubit>();
          return Scaffold(
            appBar: AppBar(title: Text('Hospital Signup')),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalTitleTextWidget(title: "Create Account"),
                  SizedBox(height: 8),
                  GlobalSubTitleTextWidget(
                    subTitle:
                        "Sign up now and start exploring all that our app has to offer. We're excited to welcome you to our community!",
                  ),
                  SizedBox(height: 8),
                  GlobalTextFormFiled(lableText: "Full Name"),
                  SizedBox(height: 8),
                  GlobalTextFormFiled(
                      lableText: "Email",
                      keyboardType: TextInputType.emailAddress),
                  SizedBox(height: 8),
                  GlobalTextFormFiled(
                      lableText: "Phone Number",
                      keyboardType: TextInputType.phone),
                  SizedBox(height: 8),
                  GlobalTextFormFiled(lableText: "Primary Contact Person"),
                  SizedBox(height: 8),
                  GlobalTextFormFiled(
                      lableText: "Password",
                      keyboardType: TextInputType.visiblePassword),
                  SizedBox(height: 8),
                  GlobalTextFormFiled(
                      lableText: "Confirm Password",
                      keyboardType: TextInputType.visiblePassword),
                  SizedBox(height: 8),
                  GlobalTextFormFiled(
                    lableText: "Current Location",
                    readOnly: true,
                    iconButton: IconButton(
                        onPressed: () {}, icon: Icon(Icons.location_on)),
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
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        state.selectedDays.isEmpty
                            ? "Select Operating Days"
                            : state.selectedDays.join(', '),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => context
                              .read<HospitalSignupCubit>()
                              .selectOpeningTime(context),
                          child: Text(
                              'Opening Time: ${state.openingTime.format(context)}'),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextButton(
                          onPressed: () => context
                              .read<HospitalSignupCubit>()
                              .selectClosingTime(context),
                          child: Text(
                              'Closing Time: ${state.closingTime.format(context)}'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  GlobalButton(
                    text: "Sign Up",
                    onTap: () {
                      // Access Cubit state data
                      final state = context.read<HospitalSignupCubit>().state;
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HospitalSignupShowDayesWidget extends StatelessWidget {
  const HospitalSignupShowDayesWidget(
      {Key? key, required this.hospitalSignupCubit})
      : super(key: key);
  final HospitalSignupCubit hospitalSignupCubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HospitalSignupCubit, HospitalSignupState>(
        bloc: hospitalSignupCubit,
        builder: (context, state) {
          return ListView(
            //  mainAxisSize: MainAxisSize.min,
            children: state.daysOfWeek.map((day) {
              return CheckboxListTile(
                title: Text(day),
                value: state.selectedDays.contains(day) ||
                    (day == 'Select all' && state.allSelected),
                onChanged: (_) => hospitalSignupCubit.toggleDay(day),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
