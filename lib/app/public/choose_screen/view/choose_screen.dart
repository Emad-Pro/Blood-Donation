import 'package:blood_donation/app/public/choose_screen/view_model/cubit/choose_cubit.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/hospital_layout/hospital_auth/hospital_login/view/hospital_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/global_button.dart';
import '../../../../core/widget/global_sub_title_text_widget.dart';
import '../../../../core/widget/global_title_text_widget.dart';
import '../../../../user_layout/user_auth/user_login/view/user_login_screen.dart';
import 'widget/build_choose_options_card.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChooseCubit(),
      child: BlocBuilder<ChooseCubit, ChooseState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<ChooseCubit>(context);
          return Scaffold(
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalTitleTextWidget(
                    title: "Choose Account Type".tr(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GlobalSubTitleTextWidget(
                      subTitle:
                          "Please select your account type to proceed, whether you want to donate or represent a hospital in need of support. Choose the option that best suits your role to help contribute to healthcare services."
                              .tr(context)),
                  const SizedBox(
                    height: 25,
                  ),
                  ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                      itemCount: cubit.chooseAccoutTypeModel.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return BuildChooseOptionCard(
                          title: cubit.chooseAccoutTypeModel[index].title
                              .tr(context),
                          image: cubit.chooseAccoutTypeModel[index].imagePath,
                          isSelected:
                              cubit.chooseAccoutTypeModel[index].index ==
                                      state.selectedIndex
                                  ? true
                                  : false,
                          onTap: () {
                            cubit.toggleChooseAccountType(
                                cubit.chooseAccoutTypeModel[index].index);
                          },
                        );
                      }),
                  const Spacer(),
                  if (state.selectedIndex > 0)
                    GlobalButton(
                        text: "Continue".tr(context),
                        onTap: () {
                          if (state.selectedIndex == 1) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const UserLoginScreen();
                            }));
                          } else if (state.selectedIndex == 2) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const HospitalLoginScreen();
                            }));
                          }
                        }),
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
