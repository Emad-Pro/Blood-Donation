// File for class HospitalFaqsSearchBar
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import '../../view_model/cubit/hospital_faqs_cubit.dart';

class HospitalFaqsSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        context.read<HospitalFaqsCubit>().searchFaqs(value, context);
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: "search_faqs".tr(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
      ),
    );
  }
}
