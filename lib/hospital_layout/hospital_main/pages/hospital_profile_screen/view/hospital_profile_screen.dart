import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/hospital_layout/hospital_main/pages/hospital_profile_screen/view_model/cubit/hospital_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/di/service_lacator.dart';
import 'widgets/hospital_porfile_edit_profile_tile.dart';
import 'widgets/hospital_profile_faqs_tile.dart';
import 'widgets/hospital_profile_header_widgets.dart';
import 'widgets/hospital_profile_loading.dart';
import 'widgets/hospital_profile_logout_tile.dart';
import 'widgets/hospital_profile_reviews_tile.dart';
import 'widgets/hospital_profile_settings_tile.dart';

class HospitalProfileScreen extends StatelessWidget {
  const HospitalProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HospitalProfileCubit, HospitalProfileState>(
      bloc: getIt<HospitalProfileCubit>()..getInfo(),
      builder: (context, state) {
        print(Supabase.instance.client.auth.currentUser!.id);
        switch (state.hospitalProfileState) {
          case RequestState.init:
          case RequestState.loading:
            return HospitalProfileLoading();
          case RequestState.success:
            return Container(
              width: double.infinity,
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary),
              child: Column(
                children: [
                  HospitalProfileHeaderWidgets(state: state),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height < 550 ||
                              MediaQuery.sizeOf(context).width < 350
                          ? MediaQuery.sizeOf(context).height / 1.9
                          : MediaQuery.sizeOf(context).height / 1.8,
                      child: ListView(
                        children: [
                          HospitalPorfileEditProfileTile(state: state),
                          ListTile(
                            contentPadding: EdgeInsets.all(15),
                            title: Text("Notifications".tr(context)),
                            leading:
                                CircleAvatar(child: Icon(Icons.notifications)),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {},
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.all(15),
                            title: Text("Appointmnet".tr(context)),
                            leading: CircleAvatar(child: Icon(Icons.timeline)),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {},
                          ),
                          HospitalProfileReviewsTile(
                            hospitalName: state.hospitalProfileModel!.name!,
                          ),
                          HospitalProfileSettingsTile(),
                          HospitalProfileFAGSTile(),
                          HospitalProfileLogoutTile(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          case RequestState.error:
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 60,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(height: 15),
                  Text(state.errorMessage!),
                ],
              ),
            );
        }
      },
    );
  }
}
