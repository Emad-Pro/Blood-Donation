import 'package:blood_donation/hospital_layout/hospital_main/pages/hospital_donor_screen/pages/hospital_donor_received_requests_page/view_model/cubit/hospital_donor_received_requests_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/di/service_lacator.dart';
import '../../../../../../../core/enum/request_state.dart';
import '../../../view/widgets/hospital_doner_build_doner_request_item.dart';
import '../model/hospital_donor_recevied_requests_model.dart';

class HospitalDonerReceivedRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HospitalDonorReceivedRequestsCubit,
        HospitalDonorReceivedRequestsState>(
      bloc: getIt<HospitalDonorReceivedRequestsCubit>()..getData(),
      builder: (context, state) {
        switch (state.hospitaldonorReceivedState) {
          case RequestState.init:
          case RequestState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case RequestState.success:
            return ListView.builder(
              itemCount: state.hospitalDonorReceviedRequestsModel!
                  .length, // Adjust based on the number of requests
              itemBuilder: (context, index) {
                return HospitalDonerBuildDonerRequestItem(
                  hospitalDonorReceviedRequestsModel:
                      state.hospitalDonorReceviedRequestsModel![index],
                );
              },
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
