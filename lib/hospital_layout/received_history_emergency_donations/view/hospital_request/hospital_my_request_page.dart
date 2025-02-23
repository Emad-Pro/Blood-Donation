import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_lacator.dart';
import '../../../../core/enum/request_state.dart';
import '../../view_model/cubit/hospital_donor_received_requests_page_cubit.dart';
import '../widget/hospital_doner_build_my_request_pending.dart';

class HospitalMyRequestPage extends StatelessWidget {
  const HospitalMyRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HospitalDonorReceivedRequestsCubit,
        HospitalDonorReceivedRequestsState>(
      bloc: getIt<HospitalDonorReceivedRequestsCubit>()..getHistoryData(),
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.historyAppointmentState) {
          case RequestState.init:
          case RequestState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case RequestState.error:
            return Center(
              child: Text(state.errorMessage!),
            );
          case RequestState.success:
            return state.historyDonorReceviedRequestsModel!.isEmpty
                ? Center(
                    child: Text("No History".tr(context)),
                  )
                : ListView.builder(
                    itemCount: state.historyDonorReceviedRequestsModel!.length,
                    itemBuilder: (context, index) {
                      return HospitalDonerBuildMyRequestPending(
                          model:
                              state.historyDonorReceviedRequestsModel![index]);
                    },
                  );
        }
      },
    );
  }
}
