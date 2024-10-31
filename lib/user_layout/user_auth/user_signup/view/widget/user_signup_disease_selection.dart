import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/user_layout/user_auth/user_signup/view_model/cubit/user_signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSignupDiseaseSelection extends StatelessWidget {
  final UserSignupCubit userSignupCubit;

  const UserSignupDiseaseSelection({super.key, required this.userSignupCubit});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserSignupCubit, UserSignupState>(
        bloc: userSignupCubit,
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: state.diseases.entries.map((entry) {
                    final disease = entry.key;
                    final isSelected = entry.value;
                    return CheckboxListTile(
                      title: Text(disease.tr(context)),
                      value: isSelected,
                      onChanged: (_) {
                        userSignupCubit.toggleDiseaseSelection(disease);
                      },
                    );
                  }).toList(),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    userSignupCubit.toggleIsDisease();
                    Navigator.pop(context);
                  },
                  child: Text("confirm".tr(context)))
            ],
          );
        },
      ),
    );
  }
}
