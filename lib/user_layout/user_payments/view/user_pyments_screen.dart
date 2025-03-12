import 'package:blood_donation/core/di/service_lacator.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/locale/cubit/localizations_cubit.dart';
import 'package:blood_donation/user_layout/user_payments/view_model/cubit/user_paymentes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enum/request_state.dart';
import 'package:intl/intl.dart';

class UserPymentsScreen extends StatelessWidget {
  const UserPymentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payments".tr(context)),
      ),
      body: BlocProvider(
        create: (context) => UserPaymentesCubit()..getPayments(),
        child: BlocBuilder<UserPaymentesCubit, UserPaymentesState>(
          builder: (context, state) {
            switch (state.getPaymentsState) {
              case RequestState.init:
              case RequestState.loading:
                return Center(child: CircularProgressIndicator());
              case RequestState.success:
                return state.paymentsModel!.isEmpty
                    ? Center(child: Text("No Payments".tr(context)))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.paymentsModel!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withValues(alpha: 0.4)),
                            child: ListTile(
                              leading: CircleAvatar(child: Icon(Icons.payment)),
                              title: Text(
                                  "${state.paymentsModel![index].item!} ,${"count".tr(context)} (${"${state.paymentsModel![index].count!}"})"),
                              trailing: Text(
                                "${state.paymentsModel![index].status!.tr(context)} (${state.paymentsModel![index].points!})",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    fontSize: 12),
                              ),
                              subtitle: Text(
                                  "${DateFormat.yMMMEd(getIt<LocalizationsCubit>().state.languageCode).format(state.paymentsModel![index].createdAt!)} ,${DateFormat.Hm(getIt<LocalizationsCubit>().state.languageCode).format(state.paymentsModel![index].createdAt!)}"),
                            ),
                          );
                        });
              case RequestState.error:
                return Center(
                    child: Text("Check Internet Connection".tr(context)));
            }
          },
        ),
      ),
    );
  }
}
