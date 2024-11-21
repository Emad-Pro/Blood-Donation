import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/hospital_faqs_model.dart';

part 'hospital_faqs_state.dart';

class HospitalFaqsCubit extends Cubit<HospitalFaqsState> {
  HospitalFaqsCubit()
      : super(HospitalFaqsState(donationInfo: List.generate(20, (_) => false)));

  final List<HospitalFaqsModel> donationInfo = [
    HospitalFaqsModel(
        question: "faq_1_question", answer: "faq_1_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_2_question", answer: "faq_2_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_3_question", answer: "faq_3_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_4_question", answer: "faq_4_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_5_question", answer: "faq_5_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_6_question", answer: "faq_6_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_7_question", answer: "faq_7_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_8_question", answer: "faq_8_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_9_question", answer: "faq_9_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_10_question", answer: "faq_10_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_11_question", answer: "faq_11_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_12_question", answer: "faq_12_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_13_question", answer: "faq_13_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_14_question", answer: "faq_14_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_15_question", answer: "faq_15_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_16_question", answer: "faq_16_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_17_question", answer: "faq_17_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_18_question", answer: "faq_18_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_19_question", answer: "faq_19_answer", isExpand: false),
    HospitalFaqsModel(
        question: "faq_20_question", answer: "faq_20_answer", isExpand: false),
  ];
  void toggleExpansion(int index) {
    final currentStates = List<bool>.from(state.donationInfo);
    currentStates[index] =
        !currentStates[index]; // Toggle the current item's state
    emit(state.copyWith(donationInfo: currentStates)); // Emit the updated state
  }

  void searchFaqs(String searchQuery, BuildContext context) {
    final matchingFaqs = donationInfo
        .where((faq) =>
            faq.question.tr(context).toLowerCase().contains(searchQuery))
        .toList();
    emit(state.copyWith(faqsSearchResult: matchingFaqs));
  }
}
