import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/hospital_layout/hospital_main/pages/hospital_profile_screen/view_model/cubit/hospital_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../app/settings_screen/view/settigns_screen.dart';
import '../../../../../core/di/service_lacator.dart';
import '../../../../hospital_edit_profile/view/hospital_edit_profile_screen.dart';
import '../../../../hospital_faqs/view/hospital_faqs_screen.dart';
import '../../../../hospital_reating/view/hospital_review_screen.dart';
import 'widget/hospital_profile_header_widgets.dart';

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
                      height: MediaQuery.sizeOf(context).height < 550
                          ? MediaQuery.sizeOf(context).height / 1.7
                          : MediaQuery.sizeOf(context).height / 1.5,
                      child: ListView(
                        children: [
                          HospitalPorfileEditProfileTile(
                            state: state,
                          ),
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
                          ListTile(
                            contentPadding: EdgeInsets.all(15),
                            title: Text("Reviews".tr(context)),
                            leading:
                                CircleAvatar(child: Icon(Icons.comment_sharp)),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HospitalReviewScreen()));
                            },
                          ),
                          HospitalProfileSettingsTile(),
                          ListTile(
                            contentPadding: EdgeInsets.all(15),
                            title: Text("FAQs".tr(context)),
                            leading: CircleAvatar(child: Icon(Icons.feed)),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HospitalFaqsScreen()));
                            },
                          ),
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

class HospitalProfileLoading extends StatelessWidget {
  const HospitalProfileLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 15),
        Text(
          "Loading...".tr(context),
        )
      ],
    ));
  }
}

class HospitalPorfileEditProfileTile extends StatelessWidget {
  const HospitalPorfileEditProfileTile({
    super.key,
    required this.state,
  });
  final HospitalProfileState state;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      title: Text("Edit Profile".tr(context)),
      leading: CircleAvatar(child: Icon(Icons.edit)),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HospitalEditProfileScreen(
                      profile: state.hospitalProfileModel!,
                    )));
      },
    );
  }
}

class HospitalProfileSettingsTile extends StatelessWidget {
  const HospitalProfileSettingsTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      title: Text("Settings".tr(context)),
      leading: CircleAvatar(child: Icon(Icons.settings)),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettignsScreen()));
      },
    );
  }
}

class HospitalProfileLogoutTile extends StatelessWidget {
  const HospitalProfileLogoutTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      title: Text("Logout".tr(context)),
      leading: CircleAvatar(child: Icon(Icons.logout)),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.1),
                    child: Center(
                      child: Icon(Icons.logout,
                          size: 55,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Are you sure to log out of your account?".tr(context),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor: WidgetStateProperty.all(
                                Theme.of(context).colorScheme.surface),
                            backgroundColor: WidgetStateProperty.all(
                                Theme.of(context).colorScheme.primary)),
                        onPressed: () {
                          Supabase.instance.client.auth.signOut();
                          Navigator.pop(context);
                        },
                        child: Text("Logout".tr(context))),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel".tr(context))),
                  ),
                ]),
              );
            });
      },
    );
  }
}
