import 'package:blood_donation/app/public/choose_screen/view/choose_screen.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/shared_preferences/cache_helper.dart';
import 'package:blood_donation/core/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

import '../../../../core/di/service_lacator.dart';
import '../../../../core/locale/cubit/localizations_cubit.dart';
import '../../../../core/style/theme/bloc/theme_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  final Color kDarkBlueColor = AppColors.primaryColor;

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            FloatingActionButton(
              heroTag: "theme",
              onPressed: () {
                final themeMode = getIt<ThemeCubit>();
                if (themeMode.state == ThemeMode.dark) {
                  themeMode.updateTheme(ThemeMode.light);
                } else if (themeMode.state == ThemeMode.light) {
                  themeMode.updateTheme(ThemeMode.dark);
                } else {
                  themeMode.updateTheme(ThemeMode.light);
                }
              },
              child: Icon(
                getIt<ThemeCubit>().state == ThemeMode.dark
                    ? Icons.dark_mode
                    : getIt<ThemeCubit>().state == ThemeMode.light
                        ? Icons.light_mode
                        : Icons.auto_awesome,
                color: Theme.of(context).colorScheme.onSurface,
                size: 25,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              heroTag: "language",
              onPressed: () {
                if (getIt<LocalizationsCubit>().state.languageCode == 'en') {
                  getIt<LocalizationsCubit>().changeLocale(const Locale('ar'));
                } else if (getIt<LocalizationsCubit>().state.languageCode ==
                    'ar') {
                  getIt<LocalizationsCubit>().changeLocale(const Locale('en'));
                }
              },
              child: Icon(
                Icons.language,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
      body: OnBoardingSlider(
        finishButtonText: 'Login'.tr(context),
        onFinish: () async {
          await CacheHelper.saveData(key: "boarding", value: true);
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const ChooseScreen(),
            ),
          );
        },
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: kDarkBlueColor,
        ),
        skipTextButton: Text(
          'Skip'.tr(context),
          style: TextStyle(
            fontSize: 16,
            color: kDarkBlueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailingFunction: () async {
          await CacheHelper.saveData(key: "boarding", value: true);
        },
        controllerColor: kDarkBlueColor,
        totalPage: 3,
        headerBackgroundColor: Theme.of(context).colorScheme.surface,
        pageBackgroundColor: Theme.of(context).colorScheme.surface,
        background: [Container(), Container(), Container()],
        speed: 1.8,
        pageBodies: [
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/images/onboarding/onboarding_one.png',
                    ),
                  ),
                  Text(
                    'onboarding_title1'.tr(context),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kDarkBlueColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'onboarding_subtitle1'.tr(context),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.2),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/onboarding/onboarding_two.png',
                  ),
                  Text(
                    'onboarding_title2'.tr(context),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kDarkBlueColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'onboarding_subtitle2'.tr(context),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.2),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/onboarding/onboarding_three.png',
                  ),
                  Text(
                    "onboarding_title3".tr(context),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kDarkBlueColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'onboarding_subtitle3'.tr(context),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.2),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
