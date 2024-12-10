import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/cubit/user_edit_profile_cubit.dart';

class UserEditProfileDiseasesButtonWidget extends StatelessWidget {
  const UserEditProfileDiseasesButtonWidget({
    super.key,
    required this.userEditProfileCubit,
  });
  final UserEditProfileCubit userEditProfileCubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: userEditProfileCubit.state.isDisease,
              onChanged: (value) {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BlocBuilder<UserEditProfileCubit,
                          UserEditProfileState>(
                        bloc: userEditProfileCubit,
                        builder: (context, state) {
                          return Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  children: userEditProfileCubit
                                      .state.diseases.entries
                                      .map((entry) {
                                    final disease = entry.key;
                                    final isSelected = entry.value;
                                    return CheckboxListTile(
                                      title: Text(disease.tr(context)),
                                      value: isSelected,
                                      onChanged: (_) {
                                        userEditProfileCubit
                                            .toggleDiseaseSelection(disease);
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    userEditProfileCubit.toggleIsDisease();
                                    Navigator.pop(context);
                                  },
                                  child: Text("confirm".tr(context)))
                            ],
                          );
                        },
                      );
                    }).then((onValue) {
                  userEditProfileCubit.toggleIsDisease();
                });
              },
            ),
            Expanded(
              child: Text(
                  "Are there any chronic diseases or contraindications to donation (prohibited diseases can be clarified, such as infectious or chronic diseases that prevent donation)"
                      .tr(context)),
            )
          ],
        ),
      ],
    );
  }
}
