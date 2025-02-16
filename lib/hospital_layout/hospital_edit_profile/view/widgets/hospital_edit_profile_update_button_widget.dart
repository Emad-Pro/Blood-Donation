import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../core/enum/request_state.dart';
import '../../../../core/widget/global_snackbar.dart';
import '../../view_model/cubit/hospital_edit_profile_cubit.dart';

class HospitalEditProfileUpdateButtonWidget extends StatelessWidget {
  const HospitalEditProfileUpdateButtonWidget({
    super.key,
    required this.cubit,
    required this.state,
    required this.isReview,
  });

  final HospitalEditProfileCubit cubit;
  final HospitalEditProfileState state;
  final bool isReview;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return state.updateProfileState == RequestState.loading
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
                      globalSnackbar(
                          context, "Please Select Work Days".tr(context),
                          backgroundColor: Colors.red);
                    } else {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.update();
                        print("isReviewsssssssss");
                      }
                    }
                  },
                  child: Text("Update".tr(context))));
    });
  }
}
