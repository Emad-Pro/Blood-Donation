import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/widget/global_button.dart';
import 'package:blood_donation/core/widget/globla_textformfiled.dart';

import 'package:blood_donation/user_layout/user_main/view/pages/user_find/view_model/cubit/user_find_hospital_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/di/service_lacator.dart';
import '../../../../../../core/enum/request_state.dart';
import 'user_main_find_hospital_result.dart';

class UserMainFindScreen extends StatelessWidget {
  const UserMainFindScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserFindHospitalCubit, UserFindHospitalState>(
      listener: (context, state) {
        if (state.searchState == RequestState.success) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UserMainFindHospitalResult(
              searchResult: state.searchResult!,
            );
          }));
        }
      },
      bloc: getIt<UserFindHospitalCubit>(),
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GlobalTextFormFiled(
                  textEditingController:
                      getIt<UserFindHospitalCubit>().nameController,
                  iconButton: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                    onPressed: null,
                  ),
                  lableText: "Search Hospital or blood center".tr(context),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              underline: Container(),
                              isExpanded: true,
                              hint: Text("Select a Governorate".tr(context)),
                              value: state.selectedGovernorate,
                              items: getIt<UserFindHospitalCubit>()
                                  .governorates
                                  .map((governorate) {
                                return DropdownMenuItem<String>(
                                  value: governorate,
                                  child: Text(governorate),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                getIt<UserFindHospitalCubit>()
                                    .toggleGovernorate(newValue!);
                              },
                            ),
                          ),
                          if (state.selectedGovernorate != null)
                            IconButton(
                              onPressed: () {
                                getIt<UserFindHospitalCubit>()
                                    .cleargovernorates();
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButton<int>(
                              underline: Container(),
                              isExpanded: true,
                              hint: Text("Select a Nearby".tr(context)),
                              value: state.selectedNearby,
                              items: getIt<UserFindHospitalCubit>()
                                  .nearby
                                  .map((governorate) {
                                return DropdownMenuItem<int>(
                                  value: governorate,
                                  child: Text(
                                      "${governorate.toString()} ${"km".tr(context)}"),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                getIt<UserFindHospitalCubit>()
                                    .toggleNearby(newValue!);
                              },
                            ),
                          ),
                          if (state.selectedNearby != null)
                            IconButton(
                              onPressed: () {
                                getIt<UserFindHospitalCubit>().clearNearby();
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              underline: Container(),
                              isExpanded: true,
                              hint: Text("Select a Day".tr(context)),
                              value: state.selectedDay,
                              items: getIt<UserFindHospitalCubit>()
                                  .dayWorking
                                  .map((day) {
                                return DropdownMenuItem<String>(
                                  value: day,
                                  child: Text(day.tr(context)),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                getIt<UserFindHospitalCubit>()
                                    .toggleDay(newValue!);
                              },
                            ),
                          ),
                          if (state.selectedDay != null)
                            IconButton(
                              onPressed: () {
                                getIt<UserFindHospitalCubit>()
                                    .clearDayWorking();
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                state.searchState == RequestState.loading
                    ? Center(child: CircularProgressIndicator())
                    : GlobalButton(
                        text: "Search".tr(context),
                        onTap: () {
                          getIt<UserFindHospitalCubit>().searchWithAllFilters();
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
