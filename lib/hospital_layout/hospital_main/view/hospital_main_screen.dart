import 'package:blood_donation/hospital_layout/hospital_main/view_model/cubit/hospital_main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_lacator.dart';

class HospitalMainScreen extends StatelessWidget {
  const HospitalMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HospitalMainCubit, HospitalMainState>(
      bloc: getIt<HospitalMainCubit>(),
      builder: (context, state) {
        final cubit = getIt<HospitalMainCubit>();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          // appBar: AppBar(
          //   title: Text(cubit.titles[state.currentIndex]),
          // ),
          body: cubit.screens[state.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Theme.of(context).colorScheme.primary,
            currentIndex: state.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: cubit.items(context),
          ),
        );
      },
    );
  }
}
