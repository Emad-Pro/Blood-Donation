// File for class HospitalFaqsList
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/cubit/hospital_faqs_cubit.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';

class HospitalFaqsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<HospitalFaqsCubit>().state;
    final listDonationFaqs = context.read<HospitalFaqsCubit>().donationInfo;

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: state.faqsSearchResult.isNotEmpty
          ? state.faqsSearchResult.length
          : listDonationFaqs.length,
      itemBuilder: (context, index) {
        final question = state.faqsSearchResult.isNotEmpty
            ? state.faqsSearchResult[index].question.tr(context)
            : listDonationFaqs[index].question.tr(context);

        final answer = state.faqsSearchResult.isNotEmpty
            ? state.faqsSearchResult[index].answer.tr(context)
            : listDonationFaqs[index].answer.tr(context);

        return Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text(
                question,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          answer,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              onExpansionChanged: (expanded) {
                context.read<HospitalFaqsCubit>().toggleExpansion(index);
              },
              trailing: Icon(
                state.donationInfo[index] ? Icons.remove : Icons.add,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
              ),
              initiallyExpanded: state.donationInfo[index],
            ),
          ),
        );
      },
    );
  }
}
