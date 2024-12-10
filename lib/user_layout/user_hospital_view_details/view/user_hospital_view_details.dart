import 'package:blood_donation/hospital_layout/hospital_main/pages/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import 'package:blood_donation/user_layout/user_hospital_view_details/view_model/cubit/user_hospital_view_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/enum/request_state.dart';

class UserHospitalViewDetails extends StatelessWidget {
  const UserHospitalViewDetails({Key? key, required this.hospitalProfileModel})
      : super(key: key);
  final HospitalProfileModel hospitalProfileModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hospitalProfileModel.name!),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.surface),
                  backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.primary),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Text("تبرع الان"),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.bloodtype_outlined)
                  ],
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => UserHospitalViewDetailsCubit()..initWebView(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("اسم المستشفي او المركز"),
                            Text(
                              hospitalProfileModel.name!,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        )),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("العنوان"),
                          Text(
                            hospitalProfileModel.currentLocation!,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("رقم الهاتف"),
                          Text(
                            hospitalProfileModel.phone!,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("البريد الالكتروني"),
                          Text(
                            hospitalProfileModel.email!,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ايام العمل"),
                          Text(
                            hospitalProfileModel.dayes!,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ساعات العمل"),
                          Text(
                            "${TimeOfDay(hour: int.parse(hospitalProfileModel.openingTime!.split(":").first), minute: int.parse(hospitalProfileModel.openingTime!.split(":").last)).format(context)} - ${TimeOfDay(hour: int.parse(hospitalProfileModel.closingTime!.split(":").first), minute: int.parse(hospitalProfileModel.closingTime!.split(":").last)).format(context)}",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              BlocBuilder<UserHospitalViewDetailsCubit,
                  UserHospitalViewDetailsState>(
                builder: (context, state) {
                  switch (state.loadWebViewstState) {
                    case RequestState.success:
                    case RequestState.loading:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case RequestState.init:
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 400,
                        padding: EdgeInsets.all(10),
                        child: Scaffold(
                          body: GoogleMap(
                            mapType: MapType.hybrid,
                            initialCameraPosition: context
                                .read<UserHospitalViewDetailsCubit>()
                                .kGooglePlex,
                            onMapCreated: (GoogleMapController controller) {
                              context
                                  .read<UserHospitalViewDetailsCubit>()
                                  .controller
                                  .complete(controller);
                            },
                          ),
                          floatingActionButton: FloatingActionButton.extended(
                            //    onPressed: _goToTheLake,
                            label: const Text('To the lake!'),
                            icon: const Icon(Icons.directions_boat),
                            onPressed: () {},
                          ),
                        ),
                      );
                    case RequestState.error:
                      return Center(
                        child: Text("data"),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
