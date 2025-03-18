import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/locale/cubit/localizations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/di/service_lacator.dart';
import '../view_model/cubit/hospital_exchenged_cubit.dart';

class HospitalExchengedScreen extends StatelessWidget {
  const HospitalExchengedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exchanged medicines".tr(context)),
      ),
      body: BlocProvider(
        create: (context) => HospitalExchengedCubit()..getExchenged(),
        child: BlocBuilder<HospitalExchengedCubit, HospitalExchengedState>(
            builder: (context, state) {
          var cubit = context.read<HospitalExchengedCubit>();

          switch (state.getExchengedState) {
            case RequestState.init:
            case RequestState.loading:
              return Center(child: CircularProgressIndicator());
            case RequestState.success:
              var reversedList =
                  state.hospitalExchangedModel!.reversed.toList();
              return ListView.builder(
                itemCount: reversedList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(child: Icon(Icons.payment)),
                          trailing: Column(
                            children: [
                              if (reversedList[index].status == 'purchased')
                                ElevatedButton(
                                  onPressed: () {
                                    cubit.changeStatus(reversedList[index].id!);
                                  },
                                  child: Text(
                                    "confirm".tr(context),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ),
                            ],
                          ),
                          title: Text(
                              "${reversedList[index].name!} , ${"count".tr(context)} (${reversedList[index].count!})"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DateFormat.yMMMEd(getIt<LocalizationsCubit>()
                                      .state
                                      .languageCode)
                                  .format(reversedList[index].createdAt!)),
                              Text(
                                  "${"status".tr(context)} : ${"${reversedList[index].status!}".tr(context)}"),
                            ],
                          ),
                        ),
                        ExpansionTile(
                          title: Text("donor info".tr(context)),
                          childrenPadding: EdgeInsets.all(10),
                          children: [
                            Row(children: [
                              Icon(Icons.person),
                              SizedBox(width: 12),
                              Text(reversedList[index]
                                  .userSignupModel!
                                  .fullName!)
                            ]),
                            Divider(),
                            Row(children: [
                              Icon(Icons.email),
                              SizedBox(width: 12),
                              Text(reversedList[index].userSignupModel!.email!)
                            ]),
                            Divider(),
                            Row(children: [
                              Icon(Icons.phone),
                              SizedBox(width: 12),
                              Text(reversedList[index].userSignupModel!.phone!)
                            ]),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            case RequestState.error:
              return Center(child: Text(state.errorMessage!));
          }
        }),
      ),
    );
  }
}
