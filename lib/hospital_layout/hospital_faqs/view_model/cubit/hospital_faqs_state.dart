// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hospital_faqs_cubit.dart';

class HospitalFaqsState extends Equatable {
  const HospitalFaqsState({
    this.donationInfo = const [],
    this.faqsSearchResult = const [],
  });
  final List<bool> donationInfo;
  final List<HospitalFaqsModel> faqsSearchResult;

  @override
  List<Object?> get props => [donationInfo, faqsSearchResult];

  HospitalFaqsState copyWith({
    List<bool>? donationInfo,
    List<HospitalFaqsModel>? faqsSearchResult,
  }) {
    return HospitalFaqsState(
      donationInfo: donationInfo ?? this.donationInfo,
      faqsSearchResult: faqsSearchResult ?? this.faqsSearchResult,
    );
  }
}
