// File for class HospitalHomeResentListview

import 'package:blood_donation/core/di/service_lacator.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/methods/convert_string_datetime.dart';
import '../../view_model/cubit/hospital_home_cubit.dart';

class HospitalHomeResentListview extends StatelessWidget {
  const HospitalHomeResentListview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
        child: BlocBuilder<HospitalHomeCubit, HospitalHomeState>(
            bloc: getIt<HospitalHomeCubit>()..getRecentDonations(),
            builder: (context, state) {
              switch (state.hospitalDonationsState) {
                case RequestState.init:
                case RequestState.loading:
                  return Center(child: CircularProgressIndicator());
                case RequestState.success:
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.hospitalDonationsModel!.length,
                      itemBuilder: (context, index) {
                        final donation = state.hospitalDonationsModel![index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              trailing: Icon(Icons.chevron_right),
                              leading: CircleAvatar(
                                child: Text(
                                  donation.bloodType!,
                                  style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              title: Text(
                                donation.donerName!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  convertStringDateTime(donation.createdAt!)),
                            ),
                          ),
                        );
                      });

                case RequestState.error:
                  return Center(child: Text(state.recentDontionsMessage));
              }
            }));
  }
}
