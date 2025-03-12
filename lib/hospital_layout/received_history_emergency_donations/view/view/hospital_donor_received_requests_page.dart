import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/widget/global_snackbar.dart';
import 'package:blood_donation/hospital_layout/received_history_emergency_donations/view_model/cubit/hospital_donor_received_requests_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_lacator.dart';
import '../../../../core/enum/request_state.dart';
import '../widget/hospital_doner_build_doner_request_item.dart';

class HospitalDonerReceivedRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HospitalDonorReceivedRequestsCubit,
        HospitalDonorReceivedRequestsState>(
      bloc: getIt<HospitalDonorReceivedRequestsCubit>()..getData(),
      listener: (context, state) {
        if (state.updateAppointmentState == RequestState.success) {
          globalSnackbar(context, "Request Updated Successfully".tr(context),
              backgroundColor: Colors.green);
          if (getIt<HospitalDonorReceivedRequestsCubit>()
              .reasonController
              .text
              .isNotEmpty) {
            getIt<HospitalDonorReceivedRequestsCubit>()
                .reasonController
                .clear();
            Navigator.pop(context);
          }
        }
        if (state.updateAppointmentState == RequestState.error) {
          globalSnackbar(context, "Request Update Failed".tr(context),
              backgroundColor: Colors.red);
        }
      },
      builder: (context, state) {
        switch (state.hospitaldonorReceivedState) {
          case RequestState.init:
          case RequestState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case RequestState.success:
            return state.hospitalDonorReceviedRequestsModel!.isEmpty
                ? Center(
                    child: Text("No Donor Requests".tr(context)),
                  )
                : ListView.builder(
                    itemCount: state.hospitalDonorReceviedRequestsModel!
                        .length, // Adjust based on the number of requests
                    itemBuilder: (context, index) {
                      return HospitalDonerBuildDonerRequestItem(
                        orderId:
                            state.historyDonorReceviedRequestsModel![index].id,
                        userprofileModel: state
                            .hospitalDonorReceviedRequestsModel![index]
                            .userprofileModel,
                        hospitalprofileModel: state
                            .hospitalDonorReceviedRequestsModel![index]
                            .hospitalprofileModel,
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
