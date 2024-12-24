import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/user_layout/user_profile/view_model/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/service_lacator.dart';
import 'widgets/user_profile_availability_and_donation_date_widgets.dart';
import 'widgets/user_profile_header_widgets.dart';
import 'widgets/user_profile_options_widgets.dart';
import 'widgets/user_profile_person_info_card_widgets.dart';

class UserMainProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      bloc: getIt<UserProfileCubit>()..getUserProfile(),
      builder: (context, state) {
        switch (state.userProfileState) {
          case RequestState.init:
          case RequestState.loading:
            return Center(child: CircularProgressIndicator());
          case RequestState.success:
            return SingleChildScrollView(
              child: Column(
                children: [
                  UserProfileHeaderWidgets(state: state),
                  UserProfilePersonInfoCardWidgets(state: state),
                  UserProfileAvailabilityAndDonationDateWidgets(state: state),
                  UserProfileOptionsWidgets(state: state),
                ],
              ),
            );
          case RequestState.error:
            return Center(
              child: Text(state.errorMessage),
            );
        }
      },
    );
  }
}
