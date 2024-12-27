import 'package:bloc/bloc.dart';

import '../../data/model/choose_accout_type_model.dart';

part 'choose_state.dart';

class ChooseCubit extends Cubit<ChooseState> {
  ChooseCubit() : super(ChooseState());

  List<ChooseAccoutTypeModel> chooseAccoutTypeModel = [
    ChooseAccoutTypeModel(
        imagePath: "assets/images/choose/blood-pressure.png",
        title: "Blood Donor",
        index: 1),
    ChooseAccoutTypeModel(
        imagePath: "assets/images/choose/medical-center.png",
        title: "Hospital Or Center Blood Donor",
        index: 2),
  ];

  toggleChooseAccountType(int selectedIndex) {
    state.selectedIndex;
    emit(state.copyWith(selectedIndex: selectedIndex));
  }
}
