import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/cubit/hospital_faqs_cubit.dart';

import 'widgets/hospital_faqs_header.dart';
import 'widgets/hospital_faqs_list.dart';
import 'widgets/hospital_faqs_search_bar.dart';

class HospitalFaqsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HospitalFaqsCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("FAQs".tr(context)),
          elevation: 0,
        ),
        body: BlocBuilder<HospitalFaqsCubit, HospitalFaqsState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  HospitalFaqsHeader(),
                  SizedBox(height: 16),

                  // Search Bar Section
                  HospitalFaqsSearchBar(),

                  // FAQ List Section
                  SizedBox(height: 16),
                  Expanded(
                    child: HospitalFaqsList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
